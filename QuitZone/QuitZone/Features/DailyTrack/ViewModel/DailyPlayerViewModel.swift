//
//  DailyPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import SwiftUI
import CoreData

class DailyPlayerViewModel: ObservableObject {
    
    @Published var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    func createDaily(cigars: Int?) {
        let daily = DailyPlayer(context: PersistenceController.shared.viewContext)
        
        daily.setValue(cigars, forKey: "cigars")
        daily.setValue(player.id, forKey: "playerID")
        daily.setValue(Date(), forKey: "timestamps")
        
        PersistenceController.shared.save()
    }
    
    func updateDaily(cigars: Int, date: Date) {
        guard let daily = getDaily(date: date) else {
            return
        }
        
        daily.setValue(cigars, forKey: "cigars")
        
        PersistenceController.shared.save()
    }
    
    func getDaily(date: Date) -> DailyPlayer? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let request: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        request.predicate = NSPredicate(format: "playerID == %@ AND timestamps >= %@ AND creationDate < %@", self.player.objectID, startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            return results.first ?? DailyPlayer()
        } catch let error as NSError {
            print("Error fetching records : \(error)")
            return nil
        }
    }
}

struct HomeDailyPlayer: View {
    @ObservedObject var dpvm: DailyPlayerViewModel
    
    init(player: Player) {
        self.dpvm = DailyPlayerViewModel(player: player)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(dpvm.player.name ?? "")
                Button("Make Daily Track") {
                    dpvm.createDaily(cigars: 2)
                }
            }
        }
    }
}



enum sheetContent: Identifiable {
    case nicotine
    case tar
    var id: Int {
        hashValue
    }
}

class TestSheetViewModel: ObservableObject {
    @Published var showSheetContentStatus: sheetContent = .nicotine
    @Published var sheetStatus: Bool = false
    @Published var showCalendar: Bool = false
    @Published var progressDataByDate: [ProgressModel] = []
    @Published var progressData: [ProgressModel] = [
        ProgressModel(date: CalendarHelper().getItemDate(day: 1, currAppDate: Date()), cigarettes: 5),
        ProgressModel(date: CalendarHelper().getItemDate(day: 2, currAppDate: Date()), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 3, currAppDate: Date()), cigarettes: 3),
        ProgressModel(date: CalendarHelper().getItemDate(day: 4, currAppDate: Date()), cigarettes: 6),
        ProgressModel(date: CalendarHelper().getItemDate(day: 5, currAppDate: Date()), cigarettes: 1),
        ProgressModel(date: CalendarHelper().getItemDate(day: 29, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 30, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 3)
    ]
    
    
}

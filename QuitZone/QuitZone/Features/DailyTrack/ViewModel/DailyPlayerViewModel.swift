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
    
    @Environment(\.managedObjectContext) private var viewContext
    @Published var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    func createDaily(cigars: Int?) {
        let entity = NSEntityDescription.entity(forEntityName: "DailyPlayer", in: viewContext)
        let daily = NSManagedObject(entity: entity!, insertInto: viewContext)
        
        daily.setValue(cigars, forKey: "cigars")
        daily.setValue(player.id, forKey: "playerID")
        daily.setValue(Date(), forKey: "timestamps")
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save daily. \(error), \(error.userInfo)")
        }
    }
    
    func updateDaily(cigars: Int, date: Date) {
        guard let daily = getDaily(date: date) else {
            return
        }
        
        daily.setValue(cigars, forKey: "cigars")
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getDaily(date: Date) -> DailyPlayer? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let request: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        request.predicate = NSPredicate(format: "playerID == %@ AND timestamps >= %@ AND creationDate < %@", self.player.id!, startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try viewContext.fetch(request)
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

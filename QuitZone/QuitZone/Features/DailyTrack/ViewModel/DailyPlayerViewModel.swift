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
    @Published var progressData: [ProgressModel] = []
    @Published var progressDataByDate: [ProgressModel] = []
    @Published var showSheetContentStatus: sheetContent = .nicotine
    @Published var sheetStatus: Bool = false
    @Published var showCalendar: Bool = false
    
    init(player: Player) {
        self.player = player
        fetchDailyPlayer()
    }
    
    func fetchDailyPlayer() {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        let fetchRequest: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "player == %@ AND date >= %@", self.player, startDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(fetchRequest)
            if results.count > 0 {
                guard let cigarattes = self.foundCigar(dailyPlayers: results) else { return }
                for result in results {
                    let progressModel: ProgressModel = ProgressModel(date: result.date ?? Date(), totalCigars: Int(result.cigars), cigarettes: cigarattes)
                    progressData.append(progressModel)
                }
            }
        } catch let error as NSError {
            print("Error fetching data: \(error), \(error.userInfo)")
        }
    }
    
    private func foundCigar(dailyPlayers: [DailyPlayer]) -> Cigarattes? {
        for cigarattes in cigarattesLists.lists {
            if cigarattes.name == dailyPlayers.first?.player?.typeOfCigarattes {
                return cigarattes
            }
        }
        return nil
    }
}

enum sheetContent: Identifiable {
    case nicotine
    case tar
    var id: Int {
        hashValue
    }
}

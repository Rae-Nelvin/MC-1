//
//  StatisticViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 05/05/23.
//

import Foundation
import CoreData

class StatisticViewModel: ObservableObject {
    
    private var player: Player
    @Published var progressData: [ProgressModel] = []
    @Published var progressDataByDate: [ProgressModel] = []
    
    init(player: Player) {
        self.player = player
    }
    
    private func fetchDailyPlayer() {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        let fetchRequest: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "player =@ AND date >= %@", self.player, startDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(fetchRequest)
            guard let cigarattes = self.foundCigar(dailyPlayers: results) else { return }
            for result in results {
                let progressModel: ProgressModel = ProgressModel(date: result.date ?? Date(), totalCigars: Int(result.cigars), cigarettes: cigarattes)
                progressDataByDate.append(progressModel)
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
    
//    func countNicotines(dailyPlayers: [DailyPlayer]) {
//        var cigarattesNicotine: Double =  0
//        for cigarattes in cigarattesLists.lists {
//            if cigarattes.name == dailyPlayers.first?.player?.typeOfCigarattes {
//                cigarattesNicotine = cigarattes.nicotine
//                break
//            }
//        }
//        for dailyPlayer in dailyPlayers {
//            self.totalNicotine = self.totalNicotine + (cigarattesNicotine * Double(dailyPlayer.cigars))
//        }
//    }
//
//    func countTar(dailyPlayers: [DailyPlayer]) {
//        var cigarattesTar: Double =  0
//        for cigarattes in cigarattesLists.lists {
//            if cigarattes.name == dailyPlayers.first?.player?.typeOfCigarattes {
//                cigarattesTar = cigarattes.tar
//                break
//            }
//        }
//        for dailyPlayer in dailyPlayers {
//            self.totalTar = self.totalTar + (cigarattesTar * Double(dailyPlayer.cigars))
//        }
//    }
}

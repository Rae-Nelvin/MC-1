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
    @Published var averageNicotine: Int = 0
    @Published var averageTar: Int = 0
    
    init(player: Player) {
        self.player = player
        updatePlayerLung()
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
        self.calculateAverageTar()
        self.calculateAverageNicotine()
    }
    
    private func calculateAverageNicotine() {
        var average: Int = 0
        for daily in progressData {
            average = average + Int(daily.nicotineConsume)
        }
        self.averageNicotine = average / progressData.count
    }
    
    private func calculateAverageTar() {
        var average: Int = 0
        for daily in progressData {
            average = average + Int(daily.tarConsume)
        }
        self.averageTar = average / progressData.count
    }
    
    private func foundCigar(dailyPlayers: [DailyPlayer]) -> Cigarattes? {
        for cigarattes in cigarattesLists.lists {
            if cigarattes.name == dailyPlayers.first?.player?.typeOfCigarattes {
                return cigarattes
            }
        }
        return nil
    }
    
    func updatePlayerLung() {
        let lvm: LungViewModel = LungViewModel(player: self.player)
        let pvm: PlayerViewModel = PlayerViewModel()
        
        pvm.updatePlayer(name: "", dob: nil, frequency: 0, smokerFor: 0, typeOfCigarattes: nil, email: "", phone: "", avatar: nil, lungCondition: lvm.calculateRegisterLungCondition(), player: self.player)
    }
}

enum sheetContent: Identifiable {
    case nicotine
    case tar
    var id: Int {
        hashValue
    }
}

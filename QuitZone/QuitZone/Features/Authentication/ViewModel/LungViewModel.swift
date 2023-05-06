//
//  LungViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 29/04/23.
//

import Foundation
import CoreData

class LungViewModel: ObservableObject {
    private var player: Player
    private var cigaratte: Cigarattes = Cigarattes(name: "Placeholder", tar: 0, nicotine: 0)
    private var progressMonthly: [ProgressModel] = []
    
    init(player: Player) {
        self.player = player
        getCigarattes()
    }
    
    private func getCigarattes() {
        for cigaratte in cigarattesLists.lists {
            if self.player.typeOfCigarattes == cigaratte.name {
                self.cigaratte = cigaratte
                break
            }
        }
    }
    
    func calculateRegisterLungCondition() -> String {
        let condition: Double = Double(self.player.frequency * self.player.smokerFor) * 30 * self.cigaratte.tar
        return self.calculateLungCondition(condition: condition)
    }
    
    func calculateLungCondition(condition: Double) -> String {
        if condition <= 6 * 30 * 6 {
            return "lunglvl1"
        } else if condition > 6 * 30 * 6 && condition <= 6 * 30 * 12 {
            return "lunglvl2"
        } else if condition > 6 * 30 * 12 && condition <= 6 * 30 * 18 {
            return "lunglvl3"
        } else if condition > 6 * 30 * 18 && condition <= 6 * 30 * 24 {
            return "lunglvl4"
        } else if condition > 6 * 30 * 24 && condition <= 6 * 30 * 30 {
            return "lunglvl5"
        } else if condition > 6 * 30 * 30 && condition <= 6 * 30 * 36 {
            return "lunglvl6"
        } else if condition > 6 * 30 * 36 && condition <= 6 * 30 * 42 {
            return "lunglvl7"
        } else if condition > 6 * 30 * 42 && condition <= 6 * 30 * 48 {
            return "lunglvl8"
        } else if condition > 6 * 30 * 48 && condition <= 6 * 30 * 54 {
            return "lunglvl9"
        } else {
            return "lunglvl10"
        }
    }
    
    private func fetchProgressMonthly() {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .month, value: -1, to: Date())!
        
        let fetchRequest: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "player == %@ AND date >= %@", self.player, startDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    let progressModel: ProgressModel = ProgressModel(date: result.date ?? Date(), totalCigars: Int(result.cigars), cigarettes: self.cigaratte)
                    progressMonthly.append(progressModel)
                }
            }
        } catch let error as NSError {
            print("Error fetching data: \(error), \(error.userInfo)")
        }
    }
    
    func calculateLoggedInLung() -> String {
        self.fetchProgressMonthly()
        guard let condition = self.player.lungCondition else { return "" }
        var average: Double = 0
        if progressMonthly.count < 29 {
            return condition
        } else {
            for daily in progressMonthly {
                average = average + Double(daily.tarConsume)
            }
            return self.calculateLungCondition(condition: average * 30)
        }
    }
}

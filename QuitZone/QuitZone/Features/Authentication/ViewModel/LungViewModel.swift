//
//  LungViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 29/04/23.
//

import Foundation
import CloudKit

class LungViewModel: ObservableObject {
    private var player: Player
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    
    init(player: Player) {
        self.player = player
    }
    
    func createPlayerLung() {
        let record = CKRecord(recordType: "PlayerLung")
        let reference = CKRecord.Reference(recordID: self.player.id ?? CKRecord.ID(recordName: "Placeholder"), action: .none)
//        let lung = PlayerLung(playerID: reference, condition: Lung(images: <#T##String#>))
//        record.setValuesForKeys(lung.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
            }
        }
    }
    
    private func calculateLungBasedOnAge() -> Double {
        let minAge = 18
        let maxAge = 60
        let ageRange = minAge - maxAge
        let age = self.calculateAge(birthDate: self.player.dob)
        let cal = age - minAge
        let result: Double = Double((cal * 5) / ageRange)
        return result
    }
    
    private func calculateAge(birthDate: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        let age = ageComponents.year!
        return age
    }
    
//    func updatePlayerLung() {
//        let predicate = NSPredicate(format: "playerID == %@", self.player.id ?? CKRecord.ID(recordName: "Placeholder"))
//        let query = CKQuery(recordType: "PlayerLung", predicate: predicate)
//        
//        dvm.read(query: query) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let records):
//                let record = records.first
//                DispatchQueue.main.async {
//                    <#code#>
//                }
//            }
//        }
//    }
}

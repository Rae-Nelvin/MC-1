//
//  CloudKitPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit

enum RecordType: String {
    case player = "Player"
}

class PlayerViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func saveUser(name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigaratte: String, iCloud: CKRecord.ID) {
        let record = CKRecord(recordType: RecordType.player.rawValue)
        let iCloudReference = CKRecord.Reference(recordID: iCloud, action: .none)
        let player = User(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigaratte: typeOfCigaratte, iCloud: iCloudReference)
        record.setValuesForKeys(player.toDictionary())
        
        // Saving record into the Database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let _ = newRecord {
                    print("SAVED")
                }
            }
        }
        
    }
}

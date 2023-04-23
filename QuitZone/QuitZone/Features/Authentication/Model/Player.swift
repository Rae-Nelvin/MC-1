//
//  Player.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 23/04/23.
//

import Foundation
import CloudKit

struct Player: Identifiable {
    var id: CKRecord.ID?
    var iCloud: CKRecord.Reference
    var name: String
    var dob: Date
    var frequency: Int
    var smokerFor: Int
    var typeOfCigarattes: String
    
    init(id: CKRecord.ID? = nil, name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigarattes: String, iCloud: CKRecord.Reference) {
        self.id = id
        self.iCloud = iCloud
        self.name = name
        self.dob = dob
        self.frequency = frequency
        self.smokerFor = smokerFor
        self.typeOfCigarattes = typeOfCigarattes
    }
    
    func toDictionary() -> [String: Any] {
        return ["iCloud": iCloud, "name": name, "dob": dob, "frequency": frequency, "smokerFor": smokerFor, "typeOfCigarattes": typeOfCigarattes]
    }

}

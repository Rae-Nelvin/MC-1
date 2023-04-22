//
//  UserModel.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import Foundation
import CloudKit

// Placeholder Delete Later
struct user {
    var name : String = "Leonardo Da Vinci"
    var dateOfBirth : String = "1 April 1050"
    var frequency : String = "Active"
    var smokerFor : String = "Not set"
    var typeOfCigarette : String = "Not set"
    var email : String = "Not set"
    var phone : String = "Not set"
}

struct User: Identifiable {
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

//
//  Challenge.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 22/04/23.
//

import Foundation
import CloudKit

struct Challenge: Identifiable {
    var id: CKRecord.ID?
    var name: String
    var description: String
    var typeID: Int
    
    init(id: CKRecord.ID? = nil, name: String, description: String, typeID: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.typeID = typeID
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name, "description": description, "typeID": typeID]
    }
}

struct ChallengeType: Identifiable {
    var id = UUID()
    var name: String
}

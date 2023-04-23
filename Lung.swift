//
//  Lung.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit

struct UserLung: Identifiable {
    var id = UUID()
    var userID: CKRecord.Reference
    var condition: LungCondition
    
    init(id: UUID = UUID(), userID: CKRecord.Reference, condition: LungCondition) {
        self.id = id
        self.userID = userID
        self.condition = condition
    }
    
    func toDictionary() -> [String: Any] {
        return ["userID": userID, "condition": condition]
    }
}

struct Lung: Identifiable {
    var id = UUID()
    let images: String
}

enum LungCondition {
    case healthy
    case slightlyBroken
    case broken
    case hardlyBroken
    case damaged
}

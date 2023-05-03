//
//  Lung.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit

//struct PlayerLung: Identifiable {
//    var id: CKRecord.ID?
//    var playerID: CKRecord.Reference
//    var condition: LungCondition
//
//    init(id: CKRecord.ID? = nil, playerID: CKRecord.Reference, condition: LungCondition) {
//        self.id = id
//        self.playerID = playerID
//        self.condition = condition
//    }
//
//    func toDictionary() -> [String: Any] {
//        return ["playerID": playerID, "condition": condition]
//    }
//}

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

//
//  TeamChallenge.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 22/04/23.
//

import Foundation
import CloudKit

struct TeamChallenge: Identifiable {
    var id: CKRecord.ID?
    var teamID: CKRecord.Reference
    var challengeID: CKRecord.Reference
    var ended_at: Date
    
    init(id: CKRecord.ID? = nil, teamID: CKRecord.Reference, challengeID: CKRecord.Reference, ended_at: Date) {
        self.id = id
        self.teamID = teamID
        self.challengeID = challengeID
        self.ended_at = ended_at
    }
    
    func toDictionary() -> [String: Any] {
        return ["teamID": teamID, "challengeID": challengeID, "ended_at": ended_at]
    }
}

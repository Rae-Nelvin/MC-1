//
//  Member.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 22/04/23.
//

import Foundation
import CloudKit

struct Member: Identifiable {
    var id: CKRecord.ID?
    var userID: CKRecord.Reference
    var teamID: CKRecord.Reference
    var score: Double
    var date_joined: Date
    
    init(id: CKRecord.ID? = nil, userID: CKRecord.Reference, teamID: CKRecord.Reference, score: Double, date_joined: Date) {
        self.id = id
        self.userID = userID
        self.teamID = teamID
        self.score = score
        self.date_joined = date_joined
    }
    
    func toDictionary() -> [String: Any] {
        return ["userID" : userID, "teamID" : teamID, "score": score, "date_joined": date_joined]
    }
}

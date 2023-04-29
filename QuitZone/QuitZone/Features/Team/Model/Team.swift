//
//  Team.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 22/04/23.
//

import Foundation
import CloudKit

struct Team: Identifiable {
    var id: CKRecord.ID?
    var name: String
    var players: Int
    var goal: String?
    var inviteCode: String?
    
    init(id: CKRecord.ID? = nil, name: String, players: Int, goal: String? = nil, inviteCode: String? = nil) {
        self.id = id
        self.name = name
        self.players = players
        self.goal = goal
        self.inviteCode = inviteCode
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name, "players": players, "goal": goal as Any, "inviteCode": inviteCode as Any]
    }
}

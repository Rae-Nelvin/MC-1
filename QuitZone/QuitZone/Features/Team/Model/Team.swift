//
//  Team.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 22/04/23.
//

import Foundation
import CloudKit

struct Team: Identifiable, Hashable {
    var id: CKRecord.ID?
    var name: String
    var players: Int
    var inviteCode: String?
    var goal: String
    
    init(id: CKRecord.ID? = nil, name: String, players: Int, inviteCode: String? = nil, goal: String) {
        self.id = id
        self.name = name
        self.players = players
        self.inviteCode = inviteCode
        self.goal = goal
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name, "players": players, "inviteCode": inviteCode, "goal": goal]
    }
}

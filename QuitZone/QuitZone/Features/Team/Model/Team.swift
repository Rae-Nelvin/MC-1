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
    
    init(id: CKRecord.ID? = nil, name: String, players: Int) {
        self.id = id
        self.name = name
        self.players = players
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name, "players": players]
    }
}

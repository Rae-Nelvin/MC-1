//
//  DailyPlayer.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 23/04/23.
//

import Foundation
import CloudKit

struct DailyPlayer: Identifiable {
    var id: CKRecord.ID?
    var playerID: CKRecord.Reference
    var cigars: Int
    var date: Date
    
    init(id: CKRecord.ID? = nil, playerID: CKRecord.Reference, cigars: Int, date: Date) {
        self.id = id
        self.playerID = playerID
        self.cigars = cigars
        self.date = date
    }
    
    func toDictionary() -> [String: Any] {
        return ["playerID": playerID, "cigars": cigars, "date": date]
    }
}

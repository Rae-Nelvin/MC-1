//
//  Mission.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 28/04/23.
//

import Foundation
import CloudKit

struct Mission: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let point: Int
    var isDone: Bool
    
    init(title: String, description: String, point: Int, isDone: Bool = false) {
        self.title = title
        self.description = description
        self.point = point
        self.isDone = isDone
    }
    
    static func compare (lhs: Mission, rhs: PlayerMission) -> Bool {
        return lhs.title == rhs.missionTitle && lhs.point == rhs.missionPoint
    }
}

struct missionLists {
    static let lists = [Mission(title: "Dummy 1", description: "Dummy 1", point: 20),
                        Mission(title: "Dummy 2", description: "Dummy 2", point: 30)]
}

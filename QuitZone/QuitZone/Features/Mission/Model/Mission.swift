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
        return lhs.title == rhs.missionTitle
    }
}

struct missionLists {
    static let lists = [Mission(title: "Mission 1", description: "Not smoking for 2 days", point: 20),
                        Mission(title: "Mission 2", description: "Not smoking for 3 days", point: 30),
                        Mission(title: "Mission 3", description: "Not smoking after eating", point: 30),
                        Mission(title: "Dummy 4", description: "Dummy 4", point: 30),
                        Mission(title: "Dummy 5", description: "Dummy 5", point: 30),
                        Mission(title: "Dummy 6", description: "Dummy 6", point: 30),
                        Mission(title: "Dummy 7", description: "Dummy 7", point: 30),
                        Mission(title: "Dummy 8", description: "Dummy 8", point: 30),
                        Mission(title: "Dummy 9", description: "Dummy 9", point: 30),
                        Mission(title: "Dummy 10", description: "Dummy 10", point: 30),
                        Mission(title: "Dummy 11", description: "Dummy 11", point: 30),
                        Mission(title: "Dummy 12", description: "Dummy 12", point: 30),
                        Mission(title: "Dummy 13", description: "Dummy 13", point: 30),
                        Mission(title: "Dummy 14", description: "Dummy 14", point: 30),
                        Mission(title: "Dummy 15", description: "Dummy 15", point: 30),
                        Mission(title: "Dummy 16", description: "Dummy 16", point: 30),
                        Mission(title: "Dummy 17", description: "Dummy 17", point: 30),
                        Mission(title: "Dummy 18", description: "Dummy 18", point: 30),
                        Mission(title: "Dummy 19", description: "Dummy 19", point: 30),
                        Mission(title: "Dummy 20", description: "Dummy 20", point: 30),]
}

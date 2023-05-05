//
//  MissionModel.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import Foundation

struct MissionModel: Identifiable {
    let id = UUID()
    let missionTitle: String
    let missionText: String
    var isDone: Bool = false
    
    init(missionTitle: String, missionText: String, isDone: Bool = false) {
        self.missionTitle = missionTitle
        self.missionText = missionText
        self.isDone = isDone
    }
}

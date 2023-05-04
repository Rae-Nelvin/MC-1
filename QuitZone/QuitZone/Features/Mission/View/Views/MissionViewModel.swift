//
//  MissionViewModel.swift
//  QuitZone
//
//  Created by ndyyy on 03/05/23.
//

import Foundation
import SwiftUI


class MissionViewModel: ObservableObject {
    let columns = Array(repeating: GridItem(), count: 5)
    @Published var data: [MissionModel] = [
        MissionModel(missionTitle: "Mission 1", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 2", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 3", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 4", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 5", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 6", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 7", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 8", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 9", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 10", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 11", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 12", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 13", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 14", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 15", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 16", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 17", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 18", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 19", missionText: "Dummy Missin Text"),
        MissionModel(missionTitle: "Mission 20", missionText: "Dummy Missin Text")
    ]
}

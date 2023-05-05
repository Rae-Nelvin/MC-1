//
//  MissionComponent.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import SwiftUI

struct MissionComponent: View {
    @Binding var mission: Mission
    @ObservedObject var mvm: MissionViewModel
    
    var body: some View {
        VStack {
            Text("")
        }
        .frame(width: 60, height: 60)
        .background(
            Image(mission.isDone ? "MissionBoxChecked" : "MissionBoxUnchecked")
                .resizable()
        )
        .padding(1)
        .onTapGesture {
            withAnimation {
                customMissionAlert(title: mission.title,
                                   message: mission.description,
                                   leftButton: "Cancel",
                                   rightButton: mission.isDone ? "Unmark" : "Mark as Done",
                                   leftAction: {
                    print("cancelled")
                },
                                   rightAction: {
                    mission.isDone ? mvm.cancelFinishedMission(mission: mission) : mvm.finishMission(mission: mission)
                })
            }
        }
    }
}

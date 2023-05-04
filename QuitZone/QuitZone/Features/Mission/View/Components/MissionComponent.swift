//
//  MissionComponent.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import SwiftUI

struct MissionComponent: View {
    @Binding var mission: MissionModel
    
    var body: some View {
        VStack {
            Text("?")
        }
        .frame(width: 60, height: 60)
        .background(
            Rectangle()
                .fill(mission.isDone ? .green : .white)
                .background(
                    Rectangle()
                        .stroke()
                )
        )
        .padding(1)
        .onTapGesture {
            withAnimation {
//                                isMissionShown.toggle()
                customMissionAlert(title: mission.missionTitle,
                                   message: mission.missionText,
                                   leftButton: "Cancel",
                                   rightButton: mission.isDone ? "Unmark" : "Mark as Done",
                                   leftAction: {
                                        print("cancelled")
                                    },
                                    rightAction: {
                                        mission.isDone.toggle()
                                    })
            }
           
        }
    }
}

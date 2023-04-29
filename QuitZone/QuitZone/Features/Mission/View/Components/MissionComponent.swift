//
//  MissionComponent.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import SwiftUI

struct MissionComponent: View {
    @Binding var data: MissionModel
    
    var body: some View {
        VStack {
            Text("?")
        }
        .frame(width: 60, height: 60)
        .background(
            Rectangle()
                .fill(data.isDone ? .green : .white)
                .background(
                    Rectangle()
                        .stroke()
                )
        )
        .padding(1)
        .onTapGesture {
            withAnimation {
//                                isMissionShown.toggle()
                customMissionAlert(title: data.missionTitle,
                                   message: data.missionText,
                                   leftButton: "Cancel",
                                   rightButton: data.isDone ? "Unmark" : "Mark as Done",
                                   leftAction: {
                                        print("cancelled")
                                    },
                                    rightAction: {
                                        data.isDone.toggle()
                                    })
            }
           
        }
    }
}

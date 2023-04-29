//
//  MissionComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI


struct MissionView: View {
    
    let columns = Array(repeating: GridItem(), count: 5)
//    @State private var isMissionShown = false
    @State private var data: [MissionModel] = [
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

    var body: some View {
        ZStack {
            //mission page
            VStack {
                Text("**Your Mission**")
                    .customText(size: 36)
                    .hAlign(.leading)
                    .padding(.bottom, 90)
                
                //MARK: Missions
                LazyVGrid(columns: columns) {
                    ForEach(data.indices, id: \.self) {index in
                        
                        //MARK: Mission Box Item
                        MissionComponent(data: $data[index])
                    }
                }
            }
            .vAlign(.top)
            .padding()
            //show mission
//            if isMissionShowed {
//                MissionAlert(isMissionShowed: $isMissionShowed,
//                             idx: $index,
//                             data: $data
//                )
//            }
        }
    }
}

//MARK: Optional Mission Alert
/*
struct MissionAlert: View {
    @Binding var isMissionShowed: Bool
    @Binding var idx: Int
    @Binding var data: [MissionModel]
    
    var body: some View {
        
        VStack {
            Text("**\(data[idx].missionTitle)**")
                .customText(size: 24)
                .padding(.bottom, 30)
            Text("\(data[idx].missionText)")
                .customText(size: 20)
            
            //button
            HStack {
                Button("Cancel") {
                    isMissionShowed = false
                }
                
                Spacer()
                
                Button(data[idx].isDone ? "UnMark" : "Mark as Done") {
                    data[idx].isDone.toggle()
                    isMissionShowed = false
                }
            }
            .padding()
        }
        .frame(width: 280, height: 200, alignment: .center)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
    }
    
}
*/

struct MissionComponent_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}

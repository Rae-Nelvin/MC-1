//
//  MissionComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MissionView: View {
    @StateObject var missionViewModel = MissionViewModels()
    
    var body: some View {
        //mission page
        VStack {
            Text("**Your Mission**")
                .customText(size: 36)
                .hAlign(.leading)
                .padding(.bottom, 90)
            
            //MARK: Missions
            LazyVGrid(columns: missionViewModel.columns) {
                ForEach(missionViewModel.data.indices, id: \.self) {index in
                    
                    //MARK: Mission Box Item
                    MissionComponent(mission: $missionViewModel.data[index])
                }
            }
        }
        .vAlign(.top)
        .padding()
    }
}

//MARK: Optional Mission Alert
/*
 show mission
            if isMissionShowed {
                MissionAlert(isMissionShowed: $isMissionShowed,
                             idx: $index,
                             data: $data
                )
            }
 
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

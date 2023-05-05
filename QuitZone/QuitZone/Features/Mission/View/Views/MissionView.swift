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
        
        VStack {
            //MARK: mission page
            VStack {
                Text("**Tasks**")
                    .font(.primary(.subPage))
                    .hAlign(.leading)
                    .padding(.bottom, -20)
                
                //MARK: progress page
                VStack {
                    Text("**Progress**")
                        .font(.secondary(.custom(25)))
                        .hAlign(.center)
                        .padding(.bottom, 10)
                    
                    GeometryReader {
                        let size = $0.size
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(.gray.opacity(0.3))
                            Rectangle()
                                .fill(.black.opacity(0.6))
                                .frame(width: missionViewModel.countDoneMission()/CGFloat(missionViewModel.data.count) * size.width)
                                .animation(.easeIn(duration: 0.5))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .frame(width: 250, height: 10)
                }
                .padding(.top, 50)
                .padding(.bottom, 30)
                
                
                //MARK: Missions
                LazyVGrid(columns: missionViewModel.columns) {
                    ForEach(missionViewModel.data.indices, id: \.self) {index in
                        
                        //MARK: Mission Box Item
                        MissionComponent(mission: $missionViewModel.data[index])
                    }
                }
                
                Spacer()
                
                //MARK: Information
                Text("Tasks will reset weekly")
                    .font(.secondary(.caption))
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.bottom, 80)
                
                
                
                
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

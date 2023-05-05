//
//  MissionComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MissionView: View {
    
    @ObservedObject var mvm: MissionViewModel
    let columns = Array(repeating: GridItem(), count: 5)
    
    init(player: Player) {
        self.mvm = MissionViewModel(player: player)
    }
    
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
                                .frame(width: CGFloat(mvm.playerMissions.count)/CGFloat(missionLists.lists.count) * size.width)
                                .animation(.easeIn(duration: 0.5))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .frame(width: 250, height: 10)
                }
                .padding(.top, 50)
                .padding(.bottom, 30)
                
                
                //MARK: Missions
                LazyVGrid(columns: columns) {
                    ForEach(mvm.missions.indices, id: \.self) { index in
                        
                        //MARK: Mission Box Item
                        MissionComponent(mission: $mvm.missions[index], mvm: self.mvm)
                    }
                }
                
                Spacer()
                
                //MARK: Information
                Text("Tasks will reset weekly")
                    .font(.secondary(.caption))
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.bottom, 150)
            }
        }
        .vAlign(.top)
        .padding()
    }
}

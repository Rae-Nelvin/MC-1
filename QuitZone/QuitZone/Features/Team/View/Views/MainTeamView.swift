//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MainTeamView: View {
        
    @ObservedObject var tvm: TeamViewModel
    
    init(player: Player) {
        self.tvm = TeamViewModel(player: player)
    }
    
    var body: some View {
        VStack{
            
//            //MARK: TITLE, CREATE & JOIN BUTTON
//            TeamListNavComponent(currentPage: $currentPage)
//                .padding(.bottom, 20)
//                .background(LinearGradient(
//                    gradient: Gradient(colors: [.white, .white.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            
            
            //MARK: MEMBER'S LIST
            ScrollView(showsIndicators: false){
                ForEach(tvm.teams, id: \.id) { team in
                    Text(team.name ?? "Placeholder")
//                    TeamListComponent(team: Team)
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 303, height: 1)
                        .offset(y:-10)
                }
            }
            .frame(maxHeight: 540)
            .padding([.leading, .trailing], 15)
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.white.opacity(0.5), lineWidth: 5)
                .blur(radius: 5)
                .unredacted())
                
        }
        .padding()
        .vAlign(.top)
        .background(
            Image("mainBackground")
                .offset(y:-10)
        )
    }
}

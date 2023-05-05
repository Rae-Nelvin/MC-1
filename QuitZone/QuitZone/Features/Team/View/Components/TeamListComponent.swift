//
//  TeamListComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 28/04/23.
//

import SwiftUI

struct TeamListComponent: View {
    
    var page:Page
    @Binding var currentPage:Page
    
    @Binding var team:Team
    @State private var isTapped = false
    
    var body: some View {
        VStack{
            Text("**\(team.name)**")
                .foregroundColor(.black)
                .offset(y: isTapped ? 10 : 1)
            Text("\(team.players) participants")
                .foregroundColor(.black)
                .offset(y: isTapped ? 10 : 1)
        }
        .background(
            Image(isTapped ? "listPressed" : "list")
                .resizable()
                .frame(width: 302.56, height: 83)
                .offset(y:11)
        )
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 50, trailing: 30))
        .onTapGesture {
            isTapped.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                isTapped.toggle()
            }
            currentPage = self.page
        }
    }
}

struct TeamList_Previews: PreviewProvider {

    @State static var gangPage:Page = Page.gangs
    @State static var team:Team = Team(name: "Team 1", players: 10, goal: "Stop merokok")

    static var previews: some View {
        TeamListComponent(page:Page.leaderboard, currentPage: $gangPage, team: $team)
    }
}




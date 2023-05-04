//
//  LeaderboardNavComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct LeaderboardNavComponent: View {
    
    @Binding var team:Team
    //curennt Page
    
    var body: some View {
        VStack{
            Text("\(team.name) Leaderboard")
                .customText(size:30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Text("**Goal:** \(team.goal)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
    }
    
}

struct LeaderboardNavComponent_Previews: PreviewProvider {
    @State static var team:Team = Team(name: "Team 1", players: 10, goal: "Mengurangi rokok 5 batang perhari")
    
    static var previews: some View {
        LeaderboardNavComponent(team: $team)
    }
}

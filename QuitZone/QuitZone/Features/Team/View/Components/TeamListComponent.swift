//
//  TeamListComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 28/04/23.
//

import SwiftUI

struct TeamListComponent: View {
    
    @State private var showPageLeaderboard = false
    @Binding var team:Team
    
    var body: some View {
        NavigationLink(destination: LeaderboardView(team: $team)) {
            VStack{
                Text("**\(team.name)**")
                    .hAlign(.leading)
                    .padding(.bottom,1)
                Text("\(team.players) participants")
                    .hAlign(.leading)
            }
            Text("My Rank **2**")
                .hAlign(.bottomTrailing)
                .padding(.top,1)
        }
        .padding(2)
        .listRowBackground(Color.gray)
    }
}

struct TeamList_Previews: PreviewProvider {
    
    @State static var team:Team = Team(name: "Team 1", players: 10, goal: "Stop merokok")
    
    static var previews: some View {
       TeamListComponent(team: $team)
    }
}




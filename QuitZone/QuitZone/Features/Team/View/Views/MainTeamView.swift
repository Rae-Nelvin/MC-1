//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MainTeamView: View {
    
    @State var teamLists:[Team] = [
        Team(name: "Team 1", players: 10, goal: "Mengurangi rokok 3 batang per hari"),
        Team(name: "Team 2", players: 8, goal: "Stop merokok"),
        Team(name: "Team 3", players: 5, goal: "Stop rokok"),
        Team(name: "Team 4", players: 12, goal: "Mengurangi rokok 3 batang per hari"),
        Team(name: "Team 5", players: 20, goal: "Mengurangi rokok 3 batang per hari")
    ]
    
    @Binding var currentPage : Page
    
    var body: some View {
        NavigationView {
            VStack{
                TeamListNavComponent(currentPage: $currentPage)
                List($teamLists, id: \.self) { team in
                    TeamListComponent(team: team)
                }
                .teamListStyle()
            }
            
        }
    }
}

extension List {
    func teamListStyle() -> some View {
        self.background(.white)
            .scrollContentBackground(.hidden)
    }
}

struct MainTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MainTeamView(currentPage: .constant(Page.gangs))
    }
}

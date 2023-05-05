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
        Team(name: "Team 5", players: 20, goal: "Mengurangi rokok 3 batang per hari"),
        Team(name: "Team 3", players: 5, goal: "Stop rokok"),
        Team(name: "Team 4", players: 12, goal: "Mengurangi rokok 3 batang per hari"),
        Team(name: "Team 5", players: 20, goal: "Mengurangi rokok 3 batang per hari"),
    ]
    
    //Paging
    @Binding var currentPage : Page
    @State var gangPage : Page = Page.gangs
    
    var body: some View {
        VStack{
            
            //MARK: TITLE, CREATE & JOIN BUTTON
            TeamListNavComponent(currentPage: $currentPage)
                .padding(.bottom, 20)
                .background(LinearGradient(
                    gradient: Gradient(colors: [.white, .white.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            
            
            //MARK: MEMBER'S LIST
            ScrollView(showsIndicators: false){
                ForEach($teamLists, id: \.self) { team in
                    TeamListComponent(page:Page.leaderboard, currentPage: $currentPage, team: team)
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

struct MainTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MainTeamView(currentPage: .constant(Page.gangs))
    }
}

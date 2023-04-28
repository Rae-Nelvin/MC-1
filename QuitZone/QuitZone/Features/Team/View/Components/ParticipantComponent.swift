//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct ParticipantComponent: View {
    
    @State var teamLists:[Team] = [Team(name: "Asoy Geboy", players: 8),
                                  Team(name: "Quit Smoke", players: 10),
                                  Team(name: "Quit Zone", players: 5)]
        
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                
                //title and create team button
                HStack{
                    Text("My Teams")
                        .customText(size:36)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    NavigationLink(
                        destination: CreateTeamComponent(),
                        label: {
                            Text("Create team")
                        }
                    )
                    .foregroundColor(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(10))
                }
                
                //list of teams
                ForEach(0 ..< teamLists.count,  id: \.self) { index in
                    TeamList(teamName: $teamLists[index].name, totalPlayers: $teamLists[index].players)
                }
            }.padding(.horizontal)
        }
    }
}

struct ParticipantComponent_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantComponent()
    }
}


struct TeamList: View {
    
    @State private var showPageLeaderboard = false

    @Binding var teamName:String
    @Binding var totalPlayers: Int
//    @Binding var userRank: Int = 2
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("**\(teamName)**")
                        .hAlign(.leading)
                    Spacer()
                    NavigationLink(
                        destination: LeaderboardComponent(),
                        label: {
                            Text(">")
                        }
                    )
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Circle().fill(.white).opacity(10))
                }
                Spacer()
                HStack{
                    Text("\(totalPlayers) participants")
                    Spacer()
                    Text("Rank: **2**")
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(10).shadow(radius: 5))
    }
}

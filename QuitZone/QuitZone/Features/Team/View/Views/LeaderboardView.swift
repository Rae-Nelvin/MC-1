//
//  LeaderboardView.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    @Binding var team:Team
    @State var members:[Member] = []
    
    //delete if integrated with backend
    @State var name:String = "Jovan"
    @State var score:Double = 10
    @State var date_joined:Date = Date()
        
    var body: some View {
        ScrollView(showsIndicators: false){
            
            //title & goal
            LeaderboardNavComponent(team: $team)
            
            //list of members, count change to members.count if integrated
            ForEach(0 ..< 5,  id: \.self) { index in
                HStack{
                    Text("\(index+1).")
                        .padding()
                        .frame(width: 55, height: 55)
                        .background(Circle().fill(.gray).opacity(10))
                    LeaderboardListComponent(name: $name, score: $score, date_joined: $date_joined)
                }
           }
            
        }.padding([.leading, .trailing], 15)
    }
    
}



struct LeaderboardView_Previews: PreviewProvider {
    
    @State static var team:Team = Team(name: "Team 1", players: 10, goal: "Mengurangi rokok 5 batang perhari")
    
    static var previews: some View {
        LeaderboardView(team: $team)
    }
}

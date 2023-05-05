////
////  LeaderboardNavComponent.swift
////  QuitZone
////
////  Created by Salsabila Zahra Chinanti on 29/04/23.
////
//
//import SwiftUI
//
//struct LeaderboardNavComponent: View {
//    
//    @Binding var team:Team
//    //curennt Page
//    
//    var body: some View {
//        VStack{
//            Text("\(team.name)")
//                .customText(size:30)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 1)
//            Text("**Goal:** \(team.goal)")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(.black, lineWidth: 1)
//                )
//        }
//        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
//    }
//    
//}
//
//struct LeaderboardNavComponent_Previews: PreviewProvider {
//    @State static var team:Team = Team()
//    
//    static var previews: some View {
//        LeaderboardNavComponent(team: $team)
//    }
//}

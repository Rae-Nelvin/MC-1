////
////  CreateTeamComponent.swift
////  QuitZone
////
////  Created by Jonathan Evan Christian on 19/04/23.
////
//
//import SwiftUI
//
//struct MainTeamView: View {
//    
//    @State var teamLists: [Team] = []
//    var body: some View {
//        NavigationView {
//            VStack{
//                TeamListNavComponent(currentPage: $currentPage)
//                List($teamLists, id: \.self) { team in
//                    TeamListComponent(team: team)
//                }
//                .teamListStyle()
//            }
//            
//        }
//    }
//}
//
//extension List {
//    func teamListStyle() -> some View {
//        self.background(.white)
//            .scrollContentBackground(.hidden)
//    }
//}
//
//struct MainTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTeamView(currentPage: .constant(Page.gangs))
//    }
//}

////
////  LeaderboardView.swift
////  QuitZone
////
////  Created by Salsabila Zahra Chinanti on 29/04/23.
////
//
//import SwiftUI
//
//
//
//struct LeaderboardView: View {
//    
//    @Binding var currentPage: Page
//
//    @Binding var team:Team
//    @State var members:[Member] = []
//    
//    //delete if integrated with backend (User & Player Model)
//    @State var picture:String = "profilePicture"
//    @State var emotion:String = "happyface"
//    @State var name:String = "Jovan"
//    @State var score:Double = 10
//    @State var date_joined:Date = Date()
//        
//    var body: some View {
//        NavigationStack{
//            VStack{
//                //MARK: TITLE & GOAL
//                LeaderboardNavComponent(team: $team)
//                
//                //MARK: MEMBER'S LIST
//                ScrollView(showsIndicators: false){
//                    ForEach(0 ..< 5,  id: \.self) { index in
//                        HStack{
//                            LeaderboardListComponent(picture: $picture, emotion:$emotion, name: $name, score: $score, date_joined: $date_joined)
//                        }
//                   }
//                }
//                .padding([.leading, .trailing], 15)
//            }
//            .padding()
//            .background(
//                Image("mainBackground")
//                    .offset(y:-10)
//            )
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    customBackButton(page: Page.gangs, text: "Gangs", currentPage: $currentPage)
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}

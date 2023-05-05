//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardListComponent: View {

    var leaderboard: Member
    
    //for binding to detail page
    @State var condition:String = "lunglvl8"
    
    var body: some View {
        VStack{
            HStack{
                
                //MARK: PROFILE & EMOJI
                ZStack{
                    if leaderboard.player?.avatar != nil {
                        Image(uiImage: UIImage(data: (leaderboard.player?.avatar)!)!)
                            .resizable()
                    } else {
                        Image("dummyUserPhoto")
                            .resizable()
                    }
                }
                .frame(width: 67.05, height: 67.05)
                .cornerRadius(.infinity)
                
                //MARK: LEADERBOARD CONTENT
                VStack{
                    HStack{
                        Text(leaderboard.player?.name ?? "Placeholder")
                            .hAlign(.leading)
                            .font(.secondary(.custom(25)))
                        Spacer()
                        buttonLeaderboardDetail(leaderboard: self.leaderboard)
                    }
                    Text("Score: \(Int(leaderboard.score))")
                        .hAlign(.leading)
                    Text("Date joined: \(dateOnly(date:leaderboard.date_joined ?? Date()))")
                        .hAlign(.leading)
                }
                .padding(.leading, 25)
            }
            .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
            
            Rectangle()
                .fill(.gray)
                .frame(width: 337.88, height: 1)
        }
        
    }
    
    func dateOnly(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

struct buttonLeaderboardDetail: View{
    
    var leaderboard: Member
    
    @State private var showingSheet = false
    @State private var isTapped = false
    
    var body: some View{
        Button {
            isTapped.toggle()
            showingSheet.toggle()
        } label: {
            Image(isTapped ? "playDark" : "play")
                .resizable()
                .frame(width: 25.85, height: 24)
        }
        .sheet(isPresented: $showingSheet, onDismiss: {
            isTapped = false
        }) {
            LeaderboardDetailView(leaderboard: self.leaderboard)
        }
    }
}

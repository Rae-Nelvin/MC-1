//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardListComponent: View {

    @Binding var picture:String
    @Binding var emotion:String
    @Binding var name:String
    @Binding var score:Double
    @Binding var date_joined:Date
    
    //for binding to detail page
    @State var condition:String = "lunglvl8"
    
    var body: some View {
        VStack{
            HStack{
                
                //MARK: PROFILE & EMOJI
                ZStack{
                    Image("\(picture)")
                        .frame(width: 67.05, height: 67.05)
                    Image("\(emotion)")
                        .resizable()
                        .frame(width: 21.33, height: 21.33)
                        .offset(x:-22, y:24)
                        .zIndex(1)
                }
                
                //MARK: LEADERBOARD CONTENT
                VStack{
                    HStack{
                        Text("**\(name)**")
                            .hAlign(.leading)
                            .font(.secondary(.custom(25)))
                        Spacer()
                        buttonLeaderboardDetail(condition: $condition, emotion: $emotion, name: $name, score: $score)
                    }
                    Text("Score: \(Int(score))")
                        .hAlign(.leading)
                    Text("Date joined: \(dateOnly(date:date_joined))")
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
    
    @State private var showingSheet = false
    @State private var isTapped = false
    
    @Binding var condition:String
    @Binding var emotion:String
    @Binding var name:String
    @Binding var score:Double

    
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
            LeaderboardDetailView(condition: $condition, emotion: $emotion, name: $name, score: $score)
        }
    }
}

struct LeaderboardListComponent_Previews: PreviewProvider {
    
    @State static var picture:String = "profilePicture"
    @State static var emotion:String = "happyface"
    @State static var name:String = "Jovan"
    @State static var score:Double = 10
    @State static var date_joined:Date = Date()
    
    static var previews: some View {
        LeaderboardListComponent(picture: $picture, emotion: $emotion, name: $name, score: $score, date_joined: $date_joined)
    }
}

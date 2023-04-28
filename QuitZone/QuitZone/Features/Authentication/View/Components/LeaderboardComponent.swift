//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardComponent: View {
    
    @State var count:Int = 1
    @State var name:String = "Asoy 1"
    @State var score:Double = 20
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                Text("Asoy Geboy Leaderboard")
                    .customText(size:30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Asoy Geboy Leaderboard description")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            LeaderboardList(count:$count, name: $name, score: $score)
            LeaderboardList(count:$count, name: $name, score: $score)
            LeaderboardList(count:$count, name: $name, score: $score)
        }.padding([.leading, .trailing], 15)

    }
}

struct LeaderboardComponent_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardComponent()
    }
}

struct LeaderboardList: View {
    
    @State private var showingSheet = false

    @Binding var count:Int
    @Binding var name:String
    @Binding var score:Double
    
    var body: some View {
        HStack{
            Text("\(count).")
                .padding()
                .frame(width: 55, height: 55)
                .background(Circle().fill(.gray).opacity(10))
            HStack{
                VStack{
                    HStack{
                        Text("**\(name)**")
                            .hAlign(.leading)
                        Spacer()
                        Button("See more"){
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            LeaderboardDetailView()
                        }
                    }
                    Spacer()
                    HStack{
                        Text("Score: \(Int(score))")
                            .hAlign(.leading)
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(10))
        }
    }
}

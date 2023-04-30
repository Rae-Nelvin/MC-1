//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardListComponent: View {
    
    @State private var showingSheet = false

    @Binding var name:String
    @Binding var score:Double
    @Binding var date_joined:Date
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("**\(name)**")
                        .hAlign(.leading)
                    Spacer()
                    Button("Compare"){
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        LeaderboardDetailView()
                    }
                }
                HStack{
                    Text("Score: \(Int(score))")
                        .hAlign(.leading)
                }
                HStack{
                    Text("Date joined: \(dateOnly(date:date_joined))")
                        .hAlign(.leading)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(10))
    }
    
    func dateOnly(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

struct LeaderboardListComponent_Previews: PreviewProvider {
    
    //for preview
    @State static var name:String = "Jovan"
    @State static var score:Double = 10
    @State static var date_joined:Date = Date()
    
    static var previews: some View {
        LeaderboardListComponent(name: $name, score: $score, date_joined: $date_joined)
    }
}

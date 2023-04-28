//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardDetailView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            Button("x") {
                dismiss()
            }
            .frame(width: 30, height: 30)
            .background(Circle().fill(.black).opacity(10))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            HStack{
                VStack{
                    Circle()
                        .frame(width: 50, height: 50)
                    Text("Me")
                    Rectangle()
                        .frame(width: 100, height: 100)
                }
                Text("Vs")
                    .padding()
                VStack{
                    Circle()
                        .frame(width: 50, height: 50)
                    Text("Friend")
                    Rectangle()
                        .frame(width: 100, height: 100)
                }
            }
            .padding(.bottom)
            VStack{
                Text("**Bingo Score**")
                    .padding(.bottom, 3)
                Text("Score")
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        
    }
}

struct Previews_LeaderboardDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardDetailView()
    }
}

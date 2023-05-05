//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardDetailView: View {
    
    var leaderboard: Member

    var body: some View {
        VStack{
            HStack{
                CompareLungComponent(member: self.leaderboard)
                    .offset(x:7)
                Text("**-**")
                    .offset(x:-5, y:22)
                CompareLungComponent(member: self.leaderboard)
                    .offset(x:-7)

            }
            .padding(.bottom)
            BingoScoreComponent(score1: .constant(20), score2: .constant(50))
        }
        .padding()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(50)

    }
}

struct closeButton:View {
    @Environment(\.dismiss) var dismiss
    @State private var didTap:Bool = false

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(didTap ? "close" : "close")
                .resizable()
                .frame(width: 31.2, height: 29)
        }
        .offset(x: -140, y:-25)
    }
}

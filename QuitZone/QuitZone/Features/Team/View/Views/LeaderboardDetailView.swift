//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardDetailView: View {
    
    @ObservedObject var bvm: BingoViewModel
    var player: Player
    var opponent: Member
    
    init(player: Player, opponent: Member) {
        self.player = player
        self.opponent = opponent
        self.bvm = BingoViewModel(player: player, opponent: opponent.player!)
    }

    var body: some View {
        VStack{
            HStack{
                CompareLungComponent(player: self.player)
                    .offset(x:7)
                Text("**-**")
                    .offset(x:-5, y:22)
                CompareLungComponent(player: self.opponent.player!)
                    .offset(x:-7)

            }
            .padding(.bottom)
            BingoScoreComponent(score1: .constant(self.bvm.playerScore), score2: .constant(self.bvm.opponentScore))
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

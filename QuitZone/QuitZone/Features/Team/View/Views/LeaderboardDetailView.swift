//
//  LeaderboardComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct LeaderboardDetailView: View {
    
    //User, Player, Lung Model
    @Binding var condition:String
    @Binding var emotion:String
    @Binding var name:String
    @Binding var score:Double

    var body: some View {
        VStack{
            closeButton()
            HStack{
                CompareLungComponent(condition: $condition, emotion: $emotion, name: $name)
                    .offset(x:7)
                Text("**-**")
                    .offset(x:-5, y:22)
                CompareLungComponent(condition: $condition, emotion: $emotion, name: $name)
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

struct Previews_LeaderboardDetailComponent_Previews: PreviewProvider {
    
    @State static var condition:String = "lunglvl8"
    @State static var name:String = "lorem"
    @State static var emotion:String = "happyface"
    @State static var score:Double = 10.0

    static var previews: some View {
        LeaderboardDetailView(condition: $condition, emotion: $emotion, name: $name, score: $score)
    }
}

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
            HStack{
                CompareLungComponent()
                Text("**Vs**")
                    .padding()
                CompareLungComponent()

            }
            .padding(.bottom)
            BingoScoreComponent()
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

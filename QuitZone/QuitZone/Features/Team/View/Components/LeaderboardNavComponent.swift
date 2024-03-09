//
//  LeaderboardNavComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct LeaderboardNavComponent: View {
    
    var team: Team
    
    var body: some View {
        VStack{
            Text(team.name ?? "Placeholder")
                .customText(size:30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            HStack {
                Text("Goal: ")
                Text(team.goal ?? "Placeholder")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1)
            )
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
    
}

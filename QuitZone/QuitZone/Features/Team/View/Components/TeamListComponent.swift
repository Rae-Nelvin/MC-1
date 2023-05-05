//
//  TeamListComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 28/04/23.
//

import SwiftUI

struct TeamListComponent: View {
    
    let team: Team
    
    var body: some View {
        ZStack {
            Image("list")
                .resizable()
                .frame(width: 302.56, height: 83)
                .offset(y:11)
            VStack{
                Text(team.name ?? "Placeholder")
                    .foregroundColor(.black)
                Text("\(team.players) participants")
                    .foregroundColor(.black)
            }
        }
        .frame(width: 302.56, height: 83)
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 50, trailing: 30))
    }
}

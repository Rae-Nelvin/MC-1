//
//  TeamListComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 28/04/23.
//

import SwiftUI

struct TeamListComponent: View {
    
    let team: Team
    @State private var isTapped = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text(team.name ?? "Placeholder")
                .foregroundColor(.black)
                .offset(y: isTapped ? 10 : 1)
            Text("\(team.players) participants")
                .foregroundColor(.black)
                .offset(y: isTapped ? 10 : 1)
        }
        .background(
            Image(isTapped ? "listPressed" : "list")
                .resizable()
                .frame(width: 302.56, height: 83)
                .offset(y:11)
        )
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 50, trailing: 30))
        .onTapGesture {
            isTapped.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                isTapped.toggle()
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}

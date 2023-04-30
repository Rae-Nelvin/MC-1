//
//  LeaderboardNavComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CreateTeamNavComponent: View {
    
    @State private var showingAlert = false
    @State private var mainTeamPage = false
        
    var body: some View {
        HStack{
            
            //nav button
            Text("Create Team")
                .customText(size:30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Spacer()
            Button("Create"){
                showingAlert.toggle()
            }
            
            //success create alert
            .alert("Congratulations!", isPresented: $showingAlert){
                Button("Ok"){
                    mainTeamPage.toggle()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Your team is created")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
    }
    
}

struct CreateTeamNavComponent_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateTeamNavComponent()
    }
}

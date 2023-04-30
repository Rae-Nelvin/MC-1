//
//  TeamListNavComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct TeamListNavComponent: View {
    
    @State private var joinAlert = false
    @State private var successAlert = false
    @State private var createPage = false
    @State private var teamCode = ""
        
    var body: some View {
        HStack{
            
            //title
            Text("My Teams")
                .customText(size:30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Spacer()
            
            //button
            NavigationLink(destination: CreateTeamView(), isActive: $createPage){
                Button("Create"){
                    createPage.toggle()
                }
            }
            Button("Join"){
                joinAlert.toggle()
            }
            
            //alert join a team
            .alert("Join a Team", isPresented: $joinAlert){
                TextField("Team code...", text: $teamCode)
                    .textInputAutocapitalization(.never)
                Button("OK", action: {
                    successAlert.toggle()
                })
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Input the team code")
            }
            
            //alert success
            .alert("Congratulations!", isPresented: $successAlert){
                Button("Ok", role: .cancel) {}
            } message: {
                Text("You've joined the team")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        
    }
    
}
struct TeamListNavComponent_Previews: PreviewProvider {
    static var previews: some View {
        TeamListNavComponent()
    }
}

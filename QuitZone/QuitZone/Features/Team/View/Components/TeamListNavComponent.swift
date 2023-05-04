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
        
    @Binding var currentPage : Page
    
    @State private var dummyBool : Bool = false
    
    var body: some View {
        HStack{
            
            //title
            Text("Gangs")
                .font(.primary(.custom(40)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Spacer()
            
            //button

            customActionButton(page: Page.createteam, text: "create", action: $dummyBool, currentPage: $currentPage)
            
            customActionButton(page: Page.gangs, text: "join", action: $joinAlert, currentPage: $currentPage)
            
//            NavigationLink(destination: CreateTeamView(), isActive: $createPage){
//
//
//                Button("Create"){
//                    createPage.toggle()
//                }
//            }
            
            
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
        TeamListNavComponent(currentPage: .constant(Page.gangs ))
    }
}

struct customActionButton: View {
    
    var page:Page
    var text:String
    @Binding var action: Bool
    @Binding var currentPage: Page
    
    var body: some View {
        Button {
            currentPage = self.page
            self.action.toggle()
        } label: {
            ZStack {
                Image("blankRectangleGray")
                    .resizable()
                    .frame(width: 91.38, height: 38)
                Text("\(text)")
                    .foregroundColor(.black)
                    .font(.secondary(.body))
                    .offset(CGSize(width: -2, height: -2))
            }
        }
    }
}

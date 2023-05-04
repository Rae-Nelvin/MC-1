//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI


struct CreateTeamView: View {
    
    @Binding var currentPage: Page
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Create Team")
                    .font(.secondary(.subtitle))
                    .padding(.horizontal,16)
                
                Spacer()
                
                //CreateTeamNavComponent()
                CreateTeamFormComponent()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    customBackButton(page: Page.gangs, text: "Gangs", currentPage: $currentPage)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    customActionButton(page: Page.createteam, text: "Create", action: $showingAlert, currentPage: $currentPage)
//                    Button("Create"){
//                        showingAlert.toggle()
//                    }
                    .alert("Congratulations!", isPresented: $showingAlert){
                        Button("Okay!"){
                            currentPage = Page.gangs
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Your team is created")
                    }
                }
            }
            
        }

    }
    
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView(currentPage: .constant(Page.createteam))
    }
}



struct customBackButton: View {
    
    var page: Page
    var text: String
    @Binding var currentPage: Page
    
    var body: some View {
        Button {
            currentPage = self.page
        } label: {
            HStack {
                Image("ButtonLeft")
                    .resizable()
                    .frame(width: 42, height: 40)
                Text("\(self.text)")
                    .foregroundColor(.black)
                    .font(.secondary(.body))
            }
        }
    }
}

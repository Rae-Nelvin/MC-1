//
//  CreateTeamFormFormComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CreateTeamFormComponent: View {
    
    @State private var teamName: String = ""
    @State private var teamGoal: String = ""
    
    @State private var invitationCode: String = ""
    @State private var generateAlert: Bool = false

    
    var body: some View {
        Form{
            Section{
                    Text("**Team Name**")
                        .hAlign(.leading)
                    TextField("Input your name...", text: $teamName)
            }
            
            Section{
                Text("**Team Goal**")
                    .hAlign(.leading)
                TextField("Ex: stop smoking within 30 days...", text: $teamGoal)
                    .frame(height: 100)
            }
            
            Section{
                HStack{
                    Text("**Invitation Code**")
                        .hAlign(.leading)
                    Spacer()
                    Button("Generate"){
                        generateAlert.toggle()
                        invitationCode = "ABCDE"
                    }
                    .alert("Team Invitation Code", isPresented: $generateAlert){
                        Button("OK", action: {
                            generateAlert.toggle()
                        })
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text(invitationCode)
                    }
                }
                
                //show invitation code after generated
                if(!generateAlert && !invitationCode.isEmpty){
                    Text(invitationCode)
                }
                
                
            }
        }
//            .scrollContentBackground(.hidden)
//            .background(Color.white)
    }
}

struct CreateTeamFormComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamFormComponent()
    }
}

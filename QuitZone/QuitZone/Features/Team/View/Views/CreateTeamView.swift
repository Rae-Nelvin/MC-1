//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//
import SwiftUI

struct CreateTeamView: View {
    
    @ObservedObject var tvm: TeamViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var teamName: String = ""
    @State private var teamGoal: String = ""
    @State private var invitationCode: String = ""
    
    var body: some View {
        NavigationView {
            //MARK: FORM
            VStack (alignment: .leading) {
                Text("Create Team")
                    .font(.secondary(.subtitle))
                    .padding(.vertical, 20)
                customTextField(question: .constant("Name"), answer: $teamName)
                    .padding(.bottom, 29)
                customTextField(question: .constant("Group Goal"), answer: $teamGoal)
                    .padding(.vertical, 35)
                customGenerateField(tvm: self.tvm, invitationCode: $invitationCode)
                    .padding(.top, 29)
            }
            .background(
                Image("mainBackground")
                    .offset(y:-10)
            )
            .vAlign(.top)
            .toolbar {
                //MARK: BACK BUTTON
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        customBackButton(text: "Back")
                    }
                }
                //MARK: CREATE BUTTON
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAlert.toggle()
                    } label: {
                        customBackButton(text: "Create")
                    }
                    .alert("Congratulations!", isPresented: $showingAlert){
                        Button("Yeay!"){
                            showingAlert.toggle()
                            tvm.createTeam(name: teamName, goal: teamGoal, invitationCode: invitationCode)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        Text("Your team is created")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

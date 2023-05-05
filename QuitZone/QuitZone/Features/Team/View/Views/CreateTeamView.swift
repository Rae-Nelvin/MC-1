////
////  CreateTeamComponent.swift
////  QuitZone
////
////  Created by Jonathan Evan Christian on 19/04/23.
////
//
//import SwiftUI
//
//
//struct CreateTeamView: View {
//    
//    @Binding var currentPage: Page
//    @State private var showingAlert = false
//    
//    
//    var body: some View {
//        NavigationStack {
//            VStack (alignment: .leading) {
//                Text("Create Team")
//                    .font(.secondary(.subtitle))
//                    .padding(.horizontal,16)
//                
//                Spacer()
//                
//                //CreateTeamNavComponent()
//                CreateTeamFormComponent()
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    customBackButton(page: Page.gangs, text: "Gangs", currentPage: $currentPage)
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    customActionButton(page: Page.createteam, text: "Create", action: $showingAlert, currentPage: $currentPage)
////                    Button("Create"){
////                        showingAlert.toggle()
////                    }
//                    .alert("Congratulations!", isPresented: $showingAlert){
//                        Button("Okay!"){
//                            currentPage = Page.gangs
//                        }
//                        Button("Cancel", role: .cancel) {}
//                    } message: {
//                        Text("Your team is created")
//                    }
//                }
//            }
//            
//        }
//
//    }
//    
//}
//
//struct CreateTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTeamView(currentPage: .constant(Page.createteam))
//    }
//}
//
//
//
//struct customBackButton: View {
//    
//    var page: Page
//    var text: String
//    @Binding var currentPage: Page
//    
//    var body: some View {
//        Button {
//            currentPage = self.page
//        } label: {
//            HStack {
//                Image("ButtonLeft")
//                    .resizable()
//                    .frame(width: 42, height: 40)
//                Text("\(self.text)")
//                    .foregroundColor(.black)
//                    .font(.secondary(.body))
//            }
//        }
//    }
//}

import SwiftUI


struct CreateTeamView: View {
    
    @Binding var currentPage: Page
    @State private var showingAlert = false
    
    @State private var teamName: String = ""
    @State private var teamGoal: String = ""
    @State private var invitationCode: String = ""
    
    var body: some View {
        NavigationStack {
            
            //MARK: FORM
            VStack (alignment: .leading) {
                Text("Create Team")
                    .font(.secondary(.subtitle))
                    .padding(.vertical, 20)
                customTextField(question: .constant("Name"), answer: $teamName)
                    .padding(.bottom, 29)
                customTextField(question: .constant("Group Goal"), answer: $teamGoal)
                    .padding(.vertical, 35)
                customGenerateField(invitationCode: $invitationCode)
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
                    customBackButton(page: Page.gangs, text: "Gangs", currentPage: $currentPage)
                }
                
                //MARK: CREATE BUTTON
                ToolbarItem(placement: .navigationBarTrailing) {
                    customActionButton(page: Page.createteam, text: "Create", action: $showingAlert, currentPage: $currentPage)
                    .alert("Congratulations!", isPresented: $showingAlert){
                        Button("Yeay!"){
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


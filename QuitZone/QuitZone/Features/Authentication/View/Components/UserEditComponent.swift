//
//  UserEditComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserEditComponent: View {
    
    @State private var tempName : String = "Leonardo Da Vinci"
    @State private var tempDateOfBirth : String = "1 April 1050"
    @State private var tempFrequency : String = "Active"
    @State private var tempSmokerFor : String = "Not set"
    @State private var tempTypeOfCigarette : String = "Not set"
    @State private var tempEmail : String = "Not set"
    @State private var tempPhone : String = "Not set"
    @Binding var currentPage: Page
    @State var dummyBool: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack {
                    VStack {
                        Text("Ini buat image")
                    }
                    .frame(width:96, height:96)
                    .background(.red)
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                    VStack (alignment: .leading) {
                        Text("Select new image")
                            .underline()
                    }
                }
                
                customTextField(question: .constant("Name"), answer: $tempName)
                customTextField(question: .constant("Date of Birth"), answer: $tempName)
                customTextField(question: .constant("Frequency"), answer: $tempName)
                customTextField(question: .constant("Smoker for..."), answer: $tempName)
                customTextField(question: .constant("Type of Cigarette"), answer: $tempName)
                customTextField(question: .constant("Email"), answer: $tempName)
                customTextField(question: .constant("Phone"), answer: $tempName)
                
//                    .padding(.bottom, 29)
                
            
                
                Spacer()
                
                
                
            }
            .padding(32)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    customActionButton(page: .profile, text: "save", action: $dummyBool, currentPage: $currentPage)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    customBackButton(page: .profile, text: "Profile", currentPage: $currentPage)
                }
            }
        }
    }
}

struct UserEditComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserEditComponent(currentPage: .constant(.editProfile))
    }
}


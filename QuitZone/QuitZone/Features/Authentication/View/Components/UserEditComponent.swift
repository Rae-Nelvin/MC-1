//
//  UserEditComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserEditComponent: View {
    
    @ObservedObject var pvm: PlayerViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var dob: Date?
    @State private var frequency: Int16 = 0
    @State private var smokerFor: Int16 = 0
    @State private var typeOfCigarettes: Cigarattes?
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var avatar: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                    
                    customTextField(question: .constant("Name"), answer: $name)
                    //                customTextField(question: .constant("Date of Birth"), answer: $dob)
                    customIntField(question: .constant("Frequency"), answer: $frequency)
                    customIntField(question: .constant("Smoker for..."), answer: $smokerFor)
                    DropdownInputField(title: "Type of Cigarattes", options: cigarattesLists.lists, selection: $typeOfCigarettes)
                    customTextField(question: .constant("Email"), answer: $email)
                    customTextField(question: .constant("Phone"), answer: $phone)
                    Spacer()
                }
                .padding(32)
                .padding(.bottom, 200)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    self.pvm.updatePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarettes, email: email, phone: phone, avatar: avatar, player: self.pvm.player)
                } label: {
                    customButton(text: "Save")
                }
                
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    customButton(text: "Back")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

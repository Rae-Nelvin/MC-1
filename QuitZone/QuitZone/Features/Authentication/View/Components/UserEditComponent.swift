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
    @State private var frequency: Int16 = 0
    @State private var smokerFor: Int16 = 0
    @State private var typeOfCigarettes: Cigarattes?
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var avatar: UIImage?
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    HStack {
                        VStack {
                            if self.pvm.player.avatar != nil && self.avatar == nil {
                                Image(uiImage: UIImage(data: self.pvm.player.avatar!)!)
                                    .resizable()
                            } else if self.avatar != nil {
                                Image(uiImage: self.avatar!)
                                    .resizable()
                            } else {
                                Image("dummyUserPhoto")
                                    .resizable()
                            }
                        }
                        .frame(width:96, height:96)
                        .background(.red)
                        .clipShape(Circle())
                        .padding(.trailing, 16)
                        VStack (alignment: .leading) {
                            customImagePicker(question: .constant("Select Your Image"), selectedImage: $avatar, showImagePicker: $showImagePicker)
                        }
                    }
                    
                    customTextField(question: .constant("Name"), answer: $name)
                    customIntField(question: .constant("Frequency"), answer: $frequency)
                    customIntField(question: .constant("Smoker for..."), answer: $smokerFor)
                    customDropdown(question: .constant("Type of Cigarattes"), answer: $typeOfCigarettes)
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
                    self.pvm.updatePlayer(name: name, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarettes, email: email, phone: phone, avatar: avatar, lungCondition: "", player: self.pvm.player)
                } label: {
                    customActionButton(text: "Save")
                }
                
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    customBackButton(text: "Back")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

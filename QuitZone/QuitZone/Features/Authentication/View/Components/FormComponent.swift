//
//  FormComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct FormComponent: View {
    
    @State private var tempvar1 : String = "Your name"
    
    @State private var tempvar3 : String = "Date of Birth"
    @State private var tempvar4 : String = ""
    
    @State private var tempvar5 : String = "How long have you smoked"
    
    @State private var tempvar7 : String = "How frequent?"
    @State private var tempvar8 : Double = 1
    
    
    @Binding var dummyUser: User
    @Binding var currentPage : String
    
    var body: some View {
        ZStack {
            VStack {
                Image("formBackground")
            }
            
            VStack {
                customTextField(question: $tempvar1, answer: $dummyUser.name)
                    .padding(.bottom, 29)
                customTextField(question: $tempvar3, answer: $dummyUser.dateOfBirth)
                    .padding(.bottom, 29)
                customTextField(question: $tempvar5, answer: $dummyUser.smokerFor)
                    .padding(.bottom, 29)
                HStack {
                    Text("\(tempvar7)")
                        .font(.secondary(.body))
                        .padding(.bottom, 6)
                    Text("(on a scale of 10)")
                        .font(.secondary(.custom(12)))
                        .padding(.bottom, 6)
                    Spacer()

                }
                HStack {
                    Slider(value: $tempvar8, in:1...10, step: 1.0)
                    Text("\(Int(tempvar8))")
                        .font(.secondary(.custom(12)))
                        .padding(.bottom, 6)
                }
                
                Button {
                    currentPage = "Home"
                } label : {
                    Text("See your lung health now!")
                        .font(.secondary(.body))
                        .padding(8)
                }
                .padding(.top, 32)
                .buttonStyle(customButtonStyle())
            }
            .frame(width:315)
        }
    }
    
}

struct FormComponent_Previews: PreviewProvider {
    
    @State static var user:User = User(name: "", dateOfBirth: "", frequency: 1, smokerFor: "", typeOfCigarette: "", email: "", phone: "")
    
    static var previews: some View {
        FormComponent(dummyUser: $user, currentPage: .constant("Form"))
    }
}

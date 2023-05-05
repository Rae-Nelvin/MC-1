//
//  FormComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct FormComponent: View {
    
    @State private var tempvar4 : String = ""
    @State private var tempvar8 : Double = 1
    
    @Binding var dummyUser: User
    @Binding var currentPage : Page
    
    var buttonText = "See your lung\nhealth now!"
    
    @State private var options:[String]=["Sampoerna", "Rokok 2", "Rokok 3", "Rokok 4"]
    
    var body: some View {        
        ZStack {
            VStack {
                Image("formBackground")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea()
        VStack {
            customTextField(question: .constant("Your name"), answer: $dummyUser.name)
                .padding(.bottom, 20)
            CustomDatePickerComponent(question: .constant("Date of birth"), dateOfBirth: $dummyUser.dateOfBirth)
                .padding(.bottom, 20)
            CustomDatePickerComponent(question: .constant("When did you start smoking?"), dateOfBirth: $dummyUser.smokerFor)
                .padding(.bottom, 20)
            CustomDropdownComponent(question: .constant("Type of Cigarette"), answer: $dummyUser.typeOfCigarette, options: $options)
                .padding(.bottom, 20)
            customSlider(question: .constant("How frequent?"), answer: $tempvar8)
            customButton(text: buttonText, currentPage: $currentPage)
            }
            .frame(width:315)
            .offset(y:28)
        }
    }
    
}

struct FormComponent_Previews: PreviewProvider {
    
    @State static var user:User = User(name: "", dateOfBirth: "", frequency: 1, smokerFor: "", typeOfCigarette: "", email: "", phone: "")
    
    static var previews: some View {
        FormComponent(dummyUser: $user, currentPage: .constant(Page.form))
    }
}

//
//  FormComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct FormComponent: View {
    
    @State private var tempvar1 : String = "Your name"
    @State private var tempvar2 : String = ""
    
    @State private var tempvar3 : String = "Date of Birth"
    @State private var tempvar4 : String = ""
    
    @State private var tempvar5 : String = "How long have you smoked"
    @State private var tempvar6 : String = ""
    
    @State private var tempvar7 : String = "How frequent?"
    @State private var tempvar8 : Int = 1
    
    var body: some View {
        VStack {
            customTextField(question: $tempvar1, answer: $tempvar2)
                .padding(.bottom, 29)
            customTextField(question: $tempvar3, answer: $tempvar4)
                .padding(.bottom, 29)
            customTextField(question: $tempvar5, answer: $tempvar6)
                .padding(.bottom, 29)
            Text("\(tempvar7)")


        }
    }
}

struct FormComponent_Previews: PreviewProvider {
    static var previews: some View {
        FormComponent()
    }
}

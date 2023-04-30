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
    @State private var tempvar8 : Double = 1
    
    var body: some View {
        VStack {
            customTextField(question: $tempvar1, answer: $tempvar2)
                .padding(.bottom, 29)
            customTextField(question: $tempvar3, answer: $tempvar4)
                .padding(.bottom, 29)
            customTextField(question: $tempvar5, answer: $tempvar6)
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


        }
        .frame(width:315)
    }
}

struct FormComponent_Previews: PreviewProvider {
    static var previews: some View {
        FormComponent()
    }
}

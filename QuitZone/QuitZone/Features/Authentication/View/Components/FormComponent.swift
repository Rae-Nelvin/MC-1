//
//  FormComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct FormComponent: View {
    
    @ObservedObject var pvm: PlayerViewModel
    
    @State private var tempvar1 : String = "Your name"
    @State private var tempvar3 : String = "Date of Birth"
    @State private var tempvar4 : String = ""
    @State private var tempvar5 : String = "How long have you smoked (Months)"
    @State private var tempvar7 : String = "How frequent?"
    @State private var tempvar8 : Double = 1
    @State private var tempvar9: String = "What cigarattes do you smoke?"
    @State private var name: String = ""
    @State private var dob: Date = Date()
    @State private var smokerFor: Int16 = 0
    @State private var frequency: Int16 = 0
    @State private var typeOfCigarettes: Cigarattes?
    var buttonText = "See your lung \nhealth now!"
    @State private var didTap:Bool = false
    
    var body: some View {        
        ZStack {
            VStack {
                Image("formBackground")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            VStack {
                customTextField(question: $tempvar1, answer: $name)
                    .padding(.bottom, 29)
                customDatePicker(question: .constant("Date of birth"), answer: $dob)
                .padding(.bottom, 20)
                customIntField(question: $tempvar5, answer: $smokerFor)
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
                    Slider(value: Binding(get: {
                        Double(frequency)
                    }, set: {
                        frequency = Int16($0)
                    }), in:1...10, step: 1)
                    Text("\(Int(frequency))")
                        .font(.secondary(.custom(12)))
                        .padding(.bottom, 6)
                }
                DropdownInputField(title: "Type of Cigarattes", options: cigarattesLists.lists, selection: $typeOfCigarettes)
                Button {
                    self.didTap.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                        self.didTap.toggle()
                    }
                    pvm.createPlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarettes ?? cigarattesLists.lists[0])
                } label : {
                    Text("\(self.buttonText)")
                        .font(.secondary(.body))
                        .foregroundColor(.black)
                        .offset(CGSize(width: 0, height: didTap ? 4 : -6))
                        .animation(nil)
                }
                .frame(width: 240, height: 80, alignment: .center)
                .padding(.all, 20)
                .background(Image(didTap ? "boardPressed" : "board")
                    .resizable()
                    .frame(width: 240, height: 80)
                )
            }
            .frame(width:315)
            .offset(y:38)
        }
    }
    
}

struct DropdownInputField: View {
    let title: String
    let options: [Cigarattes]
    @Binding var selection: Cigarattes?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Menu {
                ForEach(options, id: \.id) { option in
                    Button(action: {
                        self.selection = option
                    }) {
                        Text(option.name)
                    }
                }
            } label: {
                HStack {
                    Text(selection?.name ?? "Select an option")
                        .foregroundColor(selection == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


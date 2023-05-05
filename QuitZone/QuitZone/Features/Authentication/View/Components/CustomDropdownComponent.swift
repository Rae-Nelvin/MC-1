//
//  CustomDropdownComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 05/05/23.
//

import SwiftUI

struct CustomDropdownComponent: View {
    @Binding var question: String
    @Binding var answer: String
    @Binding var options: [String]
    @State private var isExpanded = false
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            Menu {
                VStack(alignment: .leading) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            self.answer = option
                            self.isExpanded = false
                        }) {
                            Text(option)
                        }
                    }
                }
            } label: {
                HStack{
                    Text("Choose cigarette")
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal, 12)
            .frame(width:315, height:52)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color("SystemGray"), lineWidth: 2)
            )
        }
        .frame(width:.infinity, height:82)
    }
}

//struct CustomDropdownComponent_Previews: PreviewProvider {
//
//    @State static private var dummyUser: User
//    @State static private var question:String="Type of cigarette"
//    @State static private var options:[String]=["Sampoerna", "Rokok 2", "Rokok 3", "Rokok 4"]
//
//    static var previews: some View {
//        CustomDropdownComponent(question: $question, answer: $dummyUser, options: $options)
//    }
//}

struct PREVIEW_Previews: PreviewProvider {
    
    @State static private var dummyUser: User = User()
    @State static private var question:String="Type of cigarette"

    @State static private var options:[String]=["Sampoerna", "Rokok 2", "Rokok 3", "Rokok 4"]
    
    static var previews: some View {
        CustomDropdownComponent(question: .constant("Question"), answer: $dummyUser.dateOfBirth, options: $options)
    }
}

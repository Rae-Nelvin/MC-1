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
    
    var body: some View {
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
            
            VStack (alignment: .leading) {
                Text("Name")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Date of Birth")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Frequency")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Smoker for...")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Type of cigarette")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Email")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            VStack (alignment: .leading) {
                Text("Phone")
                    .font(.callout)
                TextField("haha", text: $tempName)
                    .font(.title2)
                    .padding(.top, -10)
            }
            .frame(width:.infinity, height:52)
            .background(.gray.opacity(0.2))
            
            
            Spacer()
            
            
            
        }
        .padding(32)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //update user info
                } label: {
                    Text("Save")
                }
            }
            
            
        }
    }
}

struct UserEditComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserEditComponent()
    }
}


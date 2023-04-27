//
//  UserEditComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserEditComponent: View {
    
    @State private var tempName = "123"
    
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
                    ///
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

//BUAT TEXTFIELD DI FORM DAN EDIT USER
struct UserView: View {
//        @StateObject var habitList = HabitList()

    var body: some View {
//            ForEach(Array(habitList.habitList.enumerated()), id: \.1.id) { index, habit in
            UserFormView(user1: $user)
//        }
    }
}

struct UserFormView: View {
    @Binding var user1: user

    var body: some View {
        VStack {
            Text("\(user1.name)")
            TextField("haha", text: $user1.name)
        }
    }
}

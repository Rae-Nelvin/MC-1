//
//  UserComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserComponent: View {
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                HStack {
                    VStack {
                        Text("Ini buat image")
                    }
                    .frame(width:96, height:96)
                    .background(.red)
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                    VStack (alignment: .leading) {
                        Text("\(User().name)")
                        Text("873 yo")
                    }
                }
                
                
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text("\(User().dateOfBirth)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                HStack {
                    Text("Frequency")
                    Spacer()
                    Text("\(User().frequency)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                HStack {
                    Text("Smoker for...")
                    Spacer()
                    Text("\(User().smokerFor)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                HStack {
                    Text("Type of Cigarette")
                    Spacer()
                    Text("\(User().typeOfCigarette)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                HStack {
                    Text("Email")
                    Spacer()
                    Text("\(User().email)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                HStack {
                    Text("Phone")
                    Spacer()
                    Text("\(User().phone)")
                }
                .frame(width:.infinity, height:40)
                .background(.gray.opacity(0.2))
                
                
                
                Spacer()
            }
            .padding(32)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: UserEditComponent(),
                        label: {
                            Text("Edit")
                        }
                    )
                }
            }
        }
    }
}

struct UserComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserComponent()
    }
}

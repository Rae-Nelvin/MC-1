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
                    }
                    .frame(width:96, height:96)
                    .background(.red)
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                    VStack (alignment: .leading) {
                        Text("\(user().name)")
                        Text("873 yo")
                    }
                }
                
                
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text("\(user().dateOfBirth)")
                }
                .background(.gray)
                
                
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

//
//  UserComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserComponent: View {
    @Binding var currentPage: Page
    @State var dummyBool = false
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                HStack {
                    //MARK: Image
                    ZStack {
                        //MARK: User Image
                        VStack {
                            Image("dummyUserPhoto")
                                .resizable()
                        }
                        .frame(width:176, height:176)
                        .clipShape(Circle())
                        
                        //MARK: face icon
                        VStack (alignment: .leading){
                            Image("happyface")
                                .resizable()
                                .frame(width: 56, height: 56)
                        }
                        .offset(CGSize(width: -55, height: 80))
                    }
                    .padding(.trailing, 16)
                    
                    //MARK: User
                    VStack(alignment: .leading) {
                        Text("Leonardo Wijaya AAA YYY BBB CCC DDD")
                            .font(.secondary(.custom(30)))
                            .padding(.bottom, 0)

                        Text("17 yo")
                            .hAlign(.leading)
                            .font(.secondary(.custom(20)))
                    }
                    .padding(.top, 120)
                    .padding(.leading, -10)
                    .frame(width:130)
                }
                .padding(.bottom, 50)
                .padding(.top, -50)
                
                
                UserDetailComponent(text: "Date of Birth", detail: "1 April 1050")
                UserDetailComponent(text: "Frequency", detail: "Active")
                UserDetailComponent(text: "Smoker for...", detail: "Not set")
                UserDetailComponent(text: "Type of Cigarette", detail: "Not set")
                UserDetailComponent(text: "Email", detail: "Not set")
                UserDetailComponent(text: "Phone", detail: "Not set")
                
                Spacer()
            }
            .padding(32)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    customActionButton(page: .editProfile, text: "edit", action: $dummyBool, currentPage: $currentPage)
                }
            }
        }
    }
}

struct UserComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserComponent(currentPage: .constant(.profile))
    }
}

struct UserDetailComponent: View {
    var text: String
    var detail: String
    
    var body: some View {
        VStack {
            
            HStack {
                Text(text)
                    .font(.secondary(.body))
                Spacer()
                Text(detail)
                    .font(.secondary(.body))
            }
            .hAlign(.center)
            Divider()
                .background(.black)
        }
        .padding(.bottom, 10)
    }
}

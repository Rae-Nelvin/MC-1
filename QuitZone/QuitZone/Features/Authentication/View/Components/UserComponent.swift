//
//  UserComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct UserComponent: View {
    
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                HStack {
                    //MARK: Image
                    ZStack {
                        //MARK: User Image
                        VStack {
                            if self.pvm.player.avatar != nil {
                                Image(uiImage: UIImage(data: self.pvm.player.avatar!)!)
                            } else {
                                Image("dummyUserPhoto")
                                    .resizable()
                            }
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
                        Text(self.pvm.player.name ?? "Placeholder")
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
                
                UserDetailComponent(text: "Date of Birth", detail: pvm.convertDateToString())
                UserDetailComponent(text: "Frequency", detail: String(self.pvm.player.frequency))
                UserDetailComponent(text: "Smoker for...", detail: String(self.pvm.player.smokerFor))
                UserDetailComponent(text: "Type of Cigarette", detail: self.pvm.player.typeOfCigarattes ?? "Placeholder")
                UserDetailComponent(text: "Email", detail: self.pvm.player.email ?? "Placeholder")
                UserDetailComponent(text: "Phone", detail: self.pvm.player.phone ?? "Placeholder")
                
                Spacer()
            }
            .padding(32)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserEditComponent(pvm: self.pvm)) {
                        customButton(text: "Edit")
                    }
                }
            }
        }
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

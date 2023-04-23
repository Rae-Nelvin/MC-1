//
//  GSM.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

//buat atur Text
extension Text {
    // set kalo body brp, title brp,
    //title: 36
    //body:14
    func customText(size:Double) -> some View {
        self.font(.system(size: size))
    }
 
}

//buat atur penempatan View
extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

//warna apps kita
struct AppColor {
    static let primary1 = Color("blue")
    static let primary2 = Color("yellow")
    static let secondary = Color("green")
    static let tertiary = Color("yellow")
    private init() {}
}

//ukuran image

//button start, submit

//button nagivation bar (save, edit, create team, create)

//back button (my teams, asoy geboy, edit profile)

//text field form
    //ada text
    //ada date
    //ada dropdown

//alert


//button alert


//tabview


//user info list


//team list container


//team member list container

//search bar




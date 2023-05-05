//
//  UserView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 05/05/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        UserComponent(pvm: self.pvm)
    }
}

struct customUserActionButton: View {

    var text: String

    var body: some View {
        ZStack {
            Image("blankRectangleGray")
                .resizable()
                .frame(width: 91.38, height: 38)
            Text("\(text)")
                .foregroundColor(.black)
                .font(.secondary(.body))
                .offset(CGSize(width: -2, height: -2))
        }
    }
}

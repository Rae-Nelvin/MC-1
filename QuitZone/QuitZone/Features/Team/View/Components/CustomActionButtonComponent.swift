//
//  CustomActionButtonComponentComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 05/05/23.
//

import SwiftUI

struct CustomActionButtonComponent: View {
    
    var page:Page
    var text:String
    @Binding var action: Bool
    @Binding var currentPage: Page
    
    var body: some View {
        Button {
            currentPage = self.page
            self.action.toggle()
        } label: {
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
}

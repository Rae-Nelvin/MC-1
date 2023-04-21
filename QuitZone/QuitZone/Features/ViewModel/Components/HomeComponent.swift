//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct HomeComponent: View {
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(showsIndicators: false) {
                Text("Quit Zone")
                    .customText(size:36)
                
                Image("Lungs")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                
                //progress
                VStack {
//                    DatePicker()
//                        .datePickerStyle(.graphical)
                }
            }
            .frame(maxWidth: size.width, alignment: .center)
            .padding()
            
            
        }
    }
}

struct HomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeComponent()
    }
}

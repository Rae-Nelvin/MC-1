//
//  LungsComponent.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import SwiftUI

struct LungsComponent: View {
    //testing
    @State private var isAnimated: Bool = false
    var lungs = Lung(images: .lv10)
    
    var body: some View {
        Image(lungs.images.rawValue)
            .resizable()
            .frame(width: 301*0.7, height: 258*0.7)
            .padding(.bottom, 124)
            .scaleEffect(isAnimated ? 0.85: 0.98)
            .animation(
                Animation
                    .easeOut(duration: 1.3)
                    .repeatForever(autoreverses: true)
            )
            .hAlign(.top)
            .onAppear {
                isAnimated.toggle()
            }
    }
}


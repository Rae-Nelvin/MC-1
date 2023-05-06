//
//  LungsComponent.swift
//  QuitZone
//
//  Created by ndyyy on 29/04/23.
//

import SwiftUI

struct LungsComponent: View {
    
    @State private var isAnimated: Bool = false
    var lung: String
    
    var body: some View {
        Image(lung)
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


//
//  SplashScreenComponentView.swift
//  QuitZone
//
//  Created by ndyyy on 04/05/23.
//

import SwiftUI

struct SplashScreenComponentView: View {
    
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        VStack {
            LottieViewComponent(name: "page2", loopMode: .playOnce)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration:2.0)) {
                if pvm.isLoading == false {
                    if pvm.isRegistered == false {
                        pvm.currPage = "Register Form Screen"
                    } else {
                        pvm.currPage = "Home Screen"
                    }
                }
            }
        }
    }
}

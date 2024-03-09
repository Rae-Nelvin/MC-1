//
//  WelcomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct WelcomeComponent: View {
    
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        ZStack {
            VStack {
                LottieViewComponent(name: "page1", loopMode: .loop)
            }
            VStack {
                //tulisan quitgang
                Text("Quitgang")
                    .font(.primary(.maintitle))
                    .padding(.top, 130)
                Spacer()
                Text("Tap anywhere \nto continue")
                    .font(.secondary(.body))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 140)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.1)) {
                pvm.currPage = "Loading iCloud Screen"
            }
        }
        
    }
}

//struct WelcomeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeComponent(pvm: pvm)
//    }
//}

//
//  SplashScreenComponentView.swift
//  QuitZone
//
//  Created by ndyyy on 04/05/23.
//

import SwiftUI

struct SplashScreenComponentView: View {
    
    @State var dummyUser = User()
    @Binding var currentPage: Page
    
    var body: some View {
        VStack {
            VStack {
                LottieViewComponent(name: "testing", loopMode: .playOnce)
                    .frame(width: 350, height: 350)
                    .padding(.top, -150)
            }
        }
        .background(Image("mainBackground"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    currentPage = .form                    
                }
            }
        }
    }
}

struct SplashScreenComponentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenComponentView(currentPage: .constant(.splashScreen))
    }
}

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
            LottieViewComponent(name: "page2", loopMode: .playOnce)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration:2.0)) {
                currentPage = .form
            }
        }
    }
}
struct SplashScreenComponentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenComponentView(currentPage: .constant(.splashScreen))
    }
}

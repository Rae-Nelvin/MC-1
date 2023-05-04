//
//  WelcomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct WelcomeComponent: View {
    
    @Binding var currentPage : Page
    
    var body: some View {
        VStack (alignment: .center) {
            
            //tulisan quitgang
            Text("Quitgang")
                .font(.primary(.maintitle))
                .padding(.top, 100)
            
            //gambar rokok
            //animasi on tap gesture
            LottieViewComponent(name: "testing", loopMode: .loop)
                .frame(width: 250, height: 250)
                .padding(.top, 50)
            
            Spacer()
            
            Text("Lorem impusm dolor sit amet! \nconsectur adipiscing \n...")
                .font(.secondary(.body))
                .multilineTextAlignment(.center)
                .padding(.bottom, 100)
            //
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Image("mainBackground")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        )
        .onTapGesture {
//            currentPage = Page.form
            currentPage = .splashScreen
//            SplashScreenComponentView()
        }
    }
}

struct WelcomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeComponent(currentPage: .constant(Page.welcome))
    }
}

//
//  WelcomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct WelcomeComponent: View {
    var body: some View {
        VStack (alignment: .center) {
            
            //tulisan quitgang
            Text("Quitgang")
                .font(.primary(.regular, .maintitle))
                .padding(.top, 100)
            
            //gambar rokok
            //animasi on tap gesture
            
            Spacer()
            
            Text("Lorem impusm dolor sit amet! \nconsectur adipiscing \n...")
                .font(.secondary(.regular, .body))
                .multilineTextAlignment(.center)
                .padding(.bottom, 100)
            //
        }
        .background(Image("Main Background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct WelcomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeComponent()
    }
}

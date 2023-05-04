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
        VStack (alignment: .center) {
            
            //tulisan quitgang
            Text("Quitgang")
                .font(.primary(.maintitle))
                .padding(.top, 100)
            
            //gambar rokok
            //animasi on tap gesture
            
            Spacer()
            
            Button {
                pvm.currPage = "Loading iCloud Screen"
            } label: {
                Text("Continue")
                    .font(.secondary(.body))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100)
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .onTapGesture {
            pvm.currPage = "Loading iCloud Screen"
        }
        .background(Image("mainBackground")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
        )
        .onTapGesture {
            currentPage = Page.form
        }
    }
}

//struct WelcomeComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeComponent(pvm: pvm)
//    }
//}

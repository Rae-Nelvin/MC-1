//
//  ContentView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var pvm: PlayerViewModel = PlayerViewModel()
    
    var body: some View {
        VStack {
            switch pvm.currPage {
            case "Splash Screen" :
                WelcomeComponent(pvm: self.pvm)
            case "Loading iCloud Screen":
                LoadingComponent(pvm: self.pvm)
            case "Register Form Screen" :
                FormComponent(pvm: self.pvm)
            case "Home Screen":
                HomeComponents()
            default:
                HomeComponents()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

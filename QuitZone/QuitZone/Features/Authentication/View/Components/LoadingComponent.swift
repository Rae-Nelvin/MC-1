//
//  LoadingComponent.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 04/05/23.
//

import SwiftUI

struct LoadingComponent: View {
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        ZStack {
            Text("Loading")
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                if pvm.isLoading == false {
                    timer.invalidate()
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

//struct LoadingComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingComponent()
//    }
//}

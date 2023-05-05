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
                HomeComponents(pvm: self.pvm)
            default:
                HomeComponents(pvm: self.pvm)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationBarView : View {
    
    @Binding var currentPage : Page
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                Spacer()
                
                
                HStack {
                    
                    Spacer()
                    
                    customNavigationButton(text: "Home", page: Page.home, image: "barHome", currentPage: $currentPage)
                    
                    Spacer()
                    
                    customNavigationButton(text: "Gangs", page: Page.gangs, image: "barGangs", currentPage: $currentPage)
                    
                    Spacer()
                    
                    customNavigationButton(text: "Tasks", page: Page.task, image: "barTasks", currentPage: $currentPage)
                    
                    Spacer()
                    
                    customNavigationButton(text: "Profile", page: Page.profile, image:"barProfile", currentPage: $currentPage)
                    
                    Spacer()
                }
                .offset(CGSize(width: -7, height: 0))
                .padding(.horizontal,20)
                .frame(width: geometry.size.width, height: geometry.size.height/9)
                .background(Material.ultraThinMaterial.opacity(0.1))
            }
        }
    }
}

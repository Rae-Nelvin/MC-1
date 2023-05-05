//
//  ContentView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

struct ContentView: View {
    
    //    @State private var currentPage : String = Page.home.rawValue
    @State private var currentPage = Page.welcome
    
    @State private var dummyUser : User = User(name: "Leonardo Da Vinci", dateOfBirth: "1 April 1050", frequency: 1, smokerFor: "Not set", typeOfCigarette: "Not set", email: "Not set", phone: "Not set")
    
    var body: some View {
        VStack {
            switch currentPage {
            case Page.welcome :
                WelcomeComponent(currentPage: $currentPage)
            case Page.splashScreen:
                SplashScreenComponentView(currentPage: $currentPage)
            case Page.form :
                FormComponent(dummyUser: $dummyUser, currentPage: $currentPage)
            default:
                VStack {
                    ZStack {
                        switch currentPage {
                        case Page.home:
                            HomeView()
                        case Page.gangs:
                            MainTeamView(currentPage: $currentPage)
                        case Page.task:
                            MissionView()
                        case Page.profile:
                            UserComponent(currentPage: $currentPage)
                        case Page.createteam:
                            CreateTeamView(currentPage: $currentPage)
                        case Page.editProfile:
                            UserEditComponent(currentPage: $currentPage)
                        default:
                            HomeView()
                        }
                        // bottom tab bar
                        
                        switch currentPage {
                        case .home, .gangs, .task, .profile:
                            NavigationBarView (currentPage: $currentPage)
                        default:
                            VStack {}
                        }
                        
                    }
                }
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

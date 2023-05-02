//
//  ContentView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

struct ContentView: View {

//    MARK: INI CODE BUAT NGECEK NAMA FONT DI SYSTEM
//    init() {
//        for familyName in UIFont.familyNames {
//            print(familyName)
//
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                print("--\(fontName)")
//            }
//        }
//    }
    
    @State private var currentPage : String = "Welcome"
    
    @State private var dummyUser : User = User(name: "Leonardo Da Vinci", dateOfBirth: "1 April 1050", frequency: 1, smokerFor: "Not set", typeOfCigarette: "Not set", email: "Not set", phone: "Not set")
    
    var body: some View {
        NavigationStack {
            
            switch currentPage {
            case "Welcome":
                WelcomeComponent(currentPage: $currentPage)
            case "Form":
                FormComponent(dummyUser: $dummyUser, currentPage: $currentPage)
            default:
                VStack {
                    TabView {
                        Group {
                            HomeView()
                                .tabItem {
                                    Label("Home", systemImage: "house")
                                }
                            MainTeamView()
                                .tabItem {
                                    Label("Friends", systemImage: "network")
                                }
                            MissionView()
                                .tabItem {
                                    Label("Mission", systemImage: "scroll")
                                }
                            UserComponent()
                                .tabItem {
                                    Label("Profile", systemImage: "person")
                                }
                        }
                    }
                    .onAppear {
                        let appearance = UITabBarAppearance()
                        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                        appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))
                        // Use this appearance when scrolling behind the TabView:
                        UITabBar.appearance().standardAppearance = appearance
                        // Use this appearance when scrolled all the way up:
                        UITabBar.appearance().scrollEdgeAppearance = appearance
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

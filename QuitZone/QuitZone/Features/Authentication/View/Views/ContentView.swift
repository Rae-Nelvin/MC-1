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
    
    @State private var currentPage : String = Page.home.rawValue
    
    @State private var dummyUser : User = User(name: "Leonardo Da Vinci", dateOfBirth: "1 April 1050", frequency: 1, smokerFor: "Not set", typeOfCigarette: "Not set", email: "Not set", phone: "Not set")
    
    var body: some View {
        VStack {
            
            switch currentPage {
            case Page.welcome.rawValue :
                WelcomeComponent(currentPage: $currentPage)
            case Page.form.rawValue :
                FormComponent(dummyUser: $dummyUser, currentPage: $currentPage)
            default:
                VStack {
                    GeometryReader { geometry in
                        ZStack {
                            switch (currentPage) {
                            case Page.home.rawValue:
                                HomeView()
                            case Page.friend.rawValue:
                                MainTeamView()
                            case Page.mission.rawValue:
                                MissionView()
                            case Page.user.rawValue:
                                UserComponent()
                            default:
                                HomeView()
                            }
                            // bottom tab bar
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        currentPage = Page.home.rawValue
                                    } label: {
                                        Image("barHome")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                    Spacer()
                                    Button {
                                        currentPage = Page.friend.rawValue
                                    } label: {
                                        Image("barFriend")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                    Spacer()
                                    Button {
                                        currentPage = Page.mission.rawValue
                                    } label: {
                                        Image("barMission")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                    Spacer()
                                    Button {
                                        currentPage = Page.user.rawValue
                                    } label: {
                                        Image("barUser")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                    Spacer()
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height/9)
                                .background(Material.ultraThinMaterial.opacity(0.1))
                            }
                        }
                    }
                    
                    
//                    TabView {
//                        Group {
//                            HomeView()
//                                .tabItem {
//                                    Label {
//                                        Text("Home")
//                                    } icon :{
//                                        Image("barHome")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 100, height: 100)
//                                    }
//                                }
//                            MainTeamView()
//                                .tabItem {
//                                    Label("Friends", systemImage: "network")
//                                }
//                            MissionView()
//                                .tabItem {
//                                    Label("Mission", systemImage: "scroll")
//                                }
//                            UserComponent()
//                                .tabItem {
//                                    Label("Profile", systemImage: "person")
//                                }
//                        }
//                    }
//                    .onAppear {
//                        let appearance = UITabBarAppearance()
//                        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//                        appearance.backgroundImage = UIImage(named: "dummyUserPhoto")
////                        appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))
//                        // Use this appearance when scrolling behind the TabView:
//                        UITabBar.appearance().standardAppearance = appearance
//                        // Use this appearance when scrolled all the way up:
//                        UITabBar.appearance().scrollEdgeAppearance = appearance
//                    }
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

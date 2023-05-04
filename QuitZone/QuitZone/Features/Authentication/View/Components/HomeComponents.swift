//
//  HomeComponents.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 04/05/23.
//

import SwiftUI

struct HomeComponents: View {
    
    @ObservedObject var pvm: PlayerViewModel
    @State private var currentPage : String = Page.home.rawValue
    
    var body: some View {
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
        }    }
}

//struct HomeComponents_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeComponents()
//    }
//}

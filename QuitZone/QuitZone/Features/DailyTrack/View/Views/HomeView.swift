//
//  HomeComponents.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 04/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentPage: Page = Page.home
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    switch currentPage {
                    case Page.home:
                        HomeComponents(player: pvm.player)
                    case Page.friend:
                        MainTeamView(player: pvm.player)
                    case Page.mission:
                        MissionView(player: pvm.player)
                    case Page.user:
                        UserView(pvm: self.pvm )
                    default:
                        HomeComponents(player: pvm.player)
                    }
                    // bottom tab bar
                    VStack {
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            customNavigationButton(text: "Home", page: Page.home, image: "barHome", currentPage: $currentPage)
                            
                            Spacer()
                            
                            customNavigationButton(text: "Gangs", page: Page.friend, image: "barGangs", currentPage: $currentPage)
                            
                            Spacer()
                            
                            customNavigationButton(text: "Tasks", page: Page.mission, image: "barTasks", currentPage: $currentPage)
                            
                            Spacer()
                            
                            customNavigationButton(text: "Profile", page: Page.user, image:"barProfile", currentPage: $currentPage)
                            
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
    }
}

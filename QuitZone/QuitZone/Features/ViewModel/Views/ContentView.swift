//
//  ContentView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    Group {
                        HomeComponent()
                            .tabItem {
                                //Text("Home")
                                Label("Home", systemImage: "house")
                            }
                        ParticipantComponent()
                            .tabItem {
                                Label("Friends", systemImage: "network")
                            }
                        MissionComponent()
                            .tabItem {
                                Label("Mission", systemImage: "scroll")
                            }
                        UserComponent()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                        
                    }
                }
            }
            .navigationTitle("tes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

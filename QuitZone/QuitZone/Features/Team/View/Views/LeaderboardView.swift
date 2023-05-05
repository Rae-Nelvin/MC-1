//
//  LeaderboardView.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var lvm: LeaderboardViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(team: Team) {
        self.lvm = LeaderboardViewModel(team: team)
    }
        
    var body: some View {
        NavigationView {
            VStack {
                //MARK: TITLE & GOAL
                LeaderboardNavComponent(team: self.lvm.team)
                
                //MARK: MEMBER'S LIST
                ScrollView(showsIndicators: false){
                    ForEach(lvm.leaderboards,  id: \.id) { leaderboard in
                        HStack{
                            LeaderboardListComponent(leaderboard: leaderboard)
                        }
                   }
                }
                .padding([.leading, .trailing], 15)
            }
            .padding()
            .background(
                Image("mainBackground")
                    .offset(y:-10)
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        customBackButton(text: "Back")
                    }

                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MainTeamView: View {
        
    @ObservedObject var tvm: TeamViewModel
    
    init(player: Player) {
        self.tvm = TeamViewModel(player: player)
    }
    
    var body: some View {
        ZStack {
            switch tvm.currPage {
            case "Main Team Component":
                MainTeamComponent(tvm: self.tvm)
            case "Create Team View":
                CreateTeamView(tvm: self.tvm)
            default:
                MainTeamComponent(tvm: self.tvm)
            }
        }
    }
}

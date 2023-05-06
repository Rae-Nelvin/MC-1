//
//  BingoViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 07/05/23.
//

import Foundation

class BingoViewModel: ObservableObject {
    
    @Published var playerScore: Float = 0
    @Published var opponentScore: Float = 0
    private var player: Player
    private var opponent: Player
    
    init(player: Player, opponent: Player) {
        self.player = player
        self.opponent = opponent
    }
    
    private func countPlayerScore() {
        let mvm: MissionViewModel = MissionViewModel(player: self.player)
        self.playerScore = Float(mvm.playerMissions.count / missionLists.lists.count)
    }
    
    private func countOpponentScore() {
        let mvm: MissionViewModel = MissionViewModel(player: self.opponent)
        self.opponentScore = Float(mvm.playerMissions.count / missionLists.lists.count)
    }
}

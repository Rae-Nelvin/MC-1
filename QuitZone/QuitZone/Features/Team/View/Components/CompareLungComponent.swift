//
//  CompareLungComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CompareLungComponent:View {
    
    var player: Player
        
    var body: some View{
        VStack{
            
            ZStack{
                Image("backgroundLungDetail")
                    .resizable()
                    .frame(width: 142.75, height: 131.84)
                Image(player.lungCondition ?? "lunglvl1")
                    .resizable()
                    .frame(width: 103.79, height: 88.97)
                    .offset(x:-4, y:-1)
            }
            
            //MARK: PLAYER'S NAME
            Text(player.name ?? "Placeholder")
            
            HStack{
                ProgressBarComponent(percentage: DailyPlayerViewModel(player: player).averageNicotine, tickValue: 320, showText: true)
                    .scaleEffect(0.7)
                    .offset(x:10)
                ProgressBarComponent(percentage: DailyPlayerViewModel(player: player).averageTar, tickValue: 14, showText: true)
                    .scaleEffect(0.7)
                    .offset(x:-10)
            }
            
        }
    }
}

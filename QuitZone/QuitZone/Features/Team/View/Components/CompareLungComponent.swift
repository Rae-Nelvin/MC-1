//
//  CompareLungComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CompareLungComponent:View {
    var member: Member
        
    var body: some View{
        VStack{
            
            ZStack{
                Image("backgroundLungDetail")
                    .resizable()
                    .frame(width: 142.75, height: 131.84)
                Image("\(member.player?.condition)")
                    .resizable()
                    .frame(width: 103.79, height: 88.97)
                    .offset(x:-4, y:-1)
            }
            
            //MARK: PLAYER'S NAME
            Text(member.player?.name ?? "Placeholder")
            
            HStack{
                ProgressBarComponent(percentage: 57, tickValue: 320, showText: true)
                    .scaleEffect(0.7)
                    .offset(x:10)
                ProgressBarComponent(percentage: 75, tickValue: 14, showText: true)
                    .scaleEffect(0.7)
                    .offset(x:-10)
            }
            
        }
    }
}

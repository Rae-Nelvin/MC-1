//
//  CompareLungComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CompareLungComponent:View {
    
    //information needed: player's lung condition, emotion, and name
    @Binding var condition:String
    @Binding var emotion:String
    @Binding var name:String
        
    var body: some View{
        VStack{
            
            ZStack{
                Image("backgroundLungDetail")
                    .resizable()
                    .frame(width: 142.75, height: 131.84)
                Image("\(condition)")
                    .resizable()
                    .frame(width: 103.79, height: 88.97)
                    .offset(x:-4, y:-1)
                Image("\(emotion)")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .offset(x:-70, y:50)
                    .zIndex(1)
            }
            
            //MARK: PLAYER'S NAME
            Text("\(name)")
            
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

struct CompareLungComponent_Previews: PreviewProvider {
    
    @State static var condition:String = "lunglvl8"
    @State static var name:String = "lorem"
    @State static var emotion:String = "happyface"
    
    static var previews: some View {
        CompareLungComponent(condition: $condition, emotion: $emotion, name: $name)
    }
}

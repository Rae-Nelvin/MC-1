//
//  BingoScoreComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct BingoScoreComponent:View {
    
    var body: some View{
        VStack{
            Text("**Bingo Score**")
                .padding(.bottom, 3)
            Text("Score")
        }
    }
}

struct BingoScoreComponent_Previews: PreviewProvider {
    static var previews: some View {
        BingoScoreComponent()
    }
}

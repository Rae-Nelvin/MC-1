//
//  BingoScoreComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct ScoreBar: View {
    @Binding var progress: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                //MARK: 2nd person
                Rectangle()
                    .foregroundColor(Color.red.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(45.0)
                
                //MARK: 1st person
                Rectangle()
                    .foregroundColor(Color.yellow.opacity(0.8))
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .animation(.linear)
                    .cornerRadius(45.0)
                
                //MARK: DIVIDER
                Image("sliderCircle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .offset(x:min(CGFloat(self.progress) * geometry.size.width, geometry.size.width)-15)
                    .zIndex(1)
            }
            .background(
                Rectangle()
                .foregroundColor(Color.gray.opacity(0.3))
                .frame(width: geometry.size.width+15, height: geometry.size.height+15)
                .cornerRadius(45.0)
            )
        }
        .frame(width: 200, height: 20)

    }
}

struct BingoScoreComponent: View {
    @Binding var score1: Float
    @Binding var score2: Float
    @State var progressScore: Float = 0
    
    func getScore() {
        progressScore =  score1/(score1+score2)
    }
    
    var body: some View {
        VStack {
            ScoreBar(progress: $progressScore)
        }.onAppear(){
            getScore()
        }
    }
}

struct BingoScoreComponent_Preview: PreviewProvider {
    static var previews: some View {
        BingoScoreComponent(score1: .constant(20.0), score2: .constant(50.0))
    }
}

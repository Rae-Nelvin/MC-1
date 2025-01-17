//
//  ProgressBar.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 02/05/23.
//

import SwiftUI

struct ProgressBarComponent : View {
    
    var percentage: Int
    let tickValue : Int
    let showText : Bool
    
    func tick(at tick: Int, status: Bool) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(status ? 0.8 : 0.0)
                .frame(width: 60/CGFloat(tickValue), height: 5)
            Spacer()
        }.rotationEffect(Angle.degrees((Double(tick+Int(Double(tickValue)/5*2))/Double(tickValue) * 360)))
        
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<tickValue) { tick in
                if tick <= Int(percentage/(self.tickValue)) {
                    self.tick(at: tick, status: true)
                }
                else {
                    self.tick(at: tick, status: false)
                }
            }
            
            if showText {
                Text("\(Int(percentage))%")
                    .font(.secondary(.title))
            }
            
        }
        .frame(width: 80, height: 80, alignment: .center)
    }
}

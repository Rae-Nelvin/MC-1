//
//  ProgressBar.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 02/05/23.
//

import SwiftUI

struct ProgressBar : View {
    
    var percentage: Double
    let tickValue : Double
    let showText : Bool
    
    func tick(at tick: Int, status: Bool) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(status ? 0.8 : 0.0)
                .frame(width: 60/tickValue, height: 5)
            Spacer()
        }.rotationEffect(Angle.degrees((Double(tick+Int(Double(tickValue)/5*2))/Double(tickValue) * 360)))
        
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<Int(tickValue)) { tick in
                if tick <= Int(percentage/(100/tickValue)) {
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

//https://prafullkumar77.medium.com/how-to-make-analog-clock-using-swiftui-11a4e16a08ed

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(percentage: 95, tickValue: 30, showText: false)
    }
}

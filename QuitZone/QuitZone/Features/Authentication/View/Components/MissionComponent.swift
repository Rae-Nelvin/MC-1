//
//  MissionComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MissionComponent: View {
    
    let columns = Array(repeating: GridItem(), count: 5)
    let datas = 1...30
    
    var body: some View {
        VStack {
            Text("**Daily Mission**")
                .customText(size: 36)
                .hAlign(.center)
                .padding(.bottom, 30)
            
            LazyVGrid(columns: columns) {
                 ForEach(datas, id: \.self) {data in
                    VStack {
                        Text(String(data))
                    }
                    .frame(width: 40, height: 40)
                    .background(.red)
                    .padding(1)
                    
                }
            }
            .hAlign(.center)
            
        }
        .vAlign(.top)
        .padding()
    }
}

struct MissionComponent_Previews: PreviewProvider {
    static var previews: some View {
        MissionComponent()
    }
}

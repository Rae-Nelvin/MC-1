//
//  CompareLungComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CompareLungComponent:View {
    
    //information needed: player's image, name, and lung condition
        
    var body: some View{
        VStack{
            //change to player's image
            Circle()
                .frame(width: 50, height: 50)
            
            Text("name")
            
            //change to player's lung
            Rectangle()
                .frame(width: 100, height: 100)
        }
    }
}

struct CompareLungComponent_Previews: PreviewProvider {
    static var previews: some View {
        CompareLungComponent()
    }
}

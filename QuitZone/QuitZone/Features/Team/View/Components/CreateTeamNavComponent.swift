//
//  LeaderboardNavComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CreateTeamNavComponent: View {
        
    var body: some View {
        HStack{
            
            //nav button
            Text("Create Team")
                .customText(size:30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
    }
    
}

struct CreateTeamNavComponent_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateTeamNavComponent()
    }
}

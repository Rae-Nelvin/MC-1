//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI


struct CreateTeamView: View {
    
    var body: some View {
        VStack{
            CreateTeamNavComponent()
            CreateTeamFormComponent()
        }

    }
    
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}



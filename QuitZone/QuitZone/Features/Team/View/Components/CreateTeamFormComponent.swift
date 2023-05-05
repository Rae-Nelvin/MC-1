//
//  CreateTeamFormFormComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 29/04/23.
//

import SwiftUI

struct CreateTeamFormComponent: View {
    
    @State private var teamName: String = ""
    @State private var teamGoal: String = ""
    @State private var invitationCode: String = ""
    
    var body: some View {
        VStack{
            customTextField(question: .constant("Name"), answer: $teamName)
                .padding(.bottom, 29)
            customTextField(question: .constant("Group Goal"), answer: $teamGoal)
                .padding(.bottom, 35)
            customGenerateField(invitationCode: $invitationCode)            
        }
    }
}

struct CreateTeamFormComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamFormComponent()
    }
}

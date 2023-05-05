//
//  UserView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 05/05/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var pvm: PlayerViewModel
    
    var body: some View {
        UserComponent(pvm: self.pvm)
    }
}

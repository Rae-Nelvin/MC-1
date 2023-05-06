//
//  ProgressMode.swift
//  QuitZone
//
//  Created by ndyyy on 28/04/23.
//

import SwiftUI

struct ProgressModel: Identifiable {
    let id = UUID()
    let date: Date
    var totalCigars: Int
    var cigarettes: Cigarattes
    
    var nicotineConsume: Double {
        return Double(totalCigars) * self.cigarettes.nicotine
    }
    
    var tarConsume: Double {
        return Double(totalCigars) * self.cigarettes.tar
    }
}

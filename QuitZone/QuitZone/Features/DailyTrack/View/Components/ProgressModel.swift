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
    
    var nicotineConsume: CGFloat {
        return CGFloat(totalCigars) * self.cigarettes.nicotine
    }
    
    var tarConsume: Int {
        return totalCigars * Int(self.cigarettes.tar)
    }
    
//    var moneySpend: CGFloat {
//        return CGFloat(cigarettes) * CGFloat(self.price)
//    }
}

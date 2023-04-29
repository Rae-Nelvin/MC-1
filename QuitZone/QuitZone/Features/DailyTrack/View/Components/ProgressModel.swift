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
    var cigarettes: Int
    
    //patokan: Sampoerna
    private let nicotine = 0.8
    private let tar = 12
    private let price = 2000
    
    var nicotineConsume: CGFloat {
        return CGFloat(cigarettes) * self.nicotine
    }
    
    var tarConsume: Int {
        return cigarettes * self.tar
    }
    
    var moneySpend: CGFloat {
        return CGFloat(cigarettes) * CGFloat(self.price)
    }
}

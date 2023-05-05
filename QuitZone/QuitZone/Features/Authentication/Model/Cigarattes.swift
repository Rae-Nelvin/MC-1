//
//  Cigarattes.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 05/05/23.
//

import Foundation

struct Cigarattes: Identifiable {
    let id = UUID()
    let name: String
    let tar: Double
    let nicotine: Double
    
    init(name: String, tar: Double, nicotine: Double) {
        self.name = name
        self.tar = tar
        self.nicotine = nicotine
    }
}

struct cigarattesLists {
    static let lists : [Cigarattes] = [Cigarattes(name: "Djarum Super", tar: 25, nicotine: 1.6),
                                       Cigarattes(name: "Sampoerna A Mild", tar: 14, nicotine: 1.2),
                                       Cigarattes(name: "Gudang Garam International", tar: 34, nicotine: 2.3),
                                       Cigarattes(name: "Marlboro", tar: 14, nicotine: 1.0),
                                       Cigarattes(name: "Lucky Strike Filter", tar: 14, nicotine: 1.0),
                                       Cigarattes(name: "Dunhill", tar: 15, nicotine: 1.0),
                                       Cigarattes(name: "LA Lights", tar: 8, nicotine: 0.6),
                                       Cigarattes(name: "Surya Pro Mild", tar: 12, nicotine: 0.9),
                                       Cigarattes(name: "Esse", tar: 6, nicotine: 0.5),
                                       Cigarattes(name: "LA Bold", tar: 22, nicotine: 1.5)]
}

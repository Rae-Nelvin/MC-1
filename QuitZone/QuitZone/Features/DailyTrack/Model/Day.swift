//
//  Day.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 28/04/23.
//

import Foundation

struct Day: Identifiable {
    let id: Int
    var isFill: Bool
    var cigars: Int16
    let date: Date
    var dailyPlayer: DailyPlayer?
    
    init(id: Int, isFill: Bool, cigars: Int16, date: Date, dailyPlayer: DailyPlayer? = nil) {
        self.id = id
        self.isFill = isFill
        self.cigars = cigars
        self.date = date
        self.dailyPlayer = dailyPlayer
    }
}

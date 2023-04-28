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
    let day: String
    let date: Date
    var dailyPlayer: DailyPlayer?
    
    init(id: Int, isFill: Bool, day: String, date: Date, dailyPlayer: DailyPlayer? = nil) {
        self.id = id
        self.isFill = isFill
        self.day = day
        self.date = date
        self.dailyPlayer = dailyPlayer
    }
}

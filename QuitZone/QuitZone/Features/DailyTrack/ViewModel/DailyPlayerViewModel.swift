//
//  DailyPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import SwiftUI
import CoreData

class DailyPlayerViewModel: ObservableObject {
    
    @Published var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    
}

enum sheetContent: Identifiable {
    case nicotine
    case tar
    var id: Int {
        hashValue
    }
}

class TestSheetViewModel: ObservableObject {
    @Published var showSheetContentStatus: sheetContent = .nicotine
    @Published var sheetStatus: Bool = false
    @Published var showCalendar: Bool = false
    @Published var progressDataByDate: [ProgressModel] = []
    @Published var progressData: [ProgressModel] = [
        ProgressModel(date: CalendarHelper().getItemDate(day: 1, currAppDate: Date()), cigarettes: 5),
        ProgressModel(date: CalendarHelper().getItemDate(day: 2, currAppDate: Date()), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 3, currAppDate: Date()), cigarettes: 3),
        ProgressModel(date: CalendarHelper().getItemDate(day: 4, currAppDate: Date()), cigarettes: 6),
        ProgressModel(date: CalendarHelper().getItemDate(day: 5, currAppDate: Date()), cigarettes: 1),
        ProgressModel(date: CalendarHelper().getItemDate(day: 29, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 30, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 3)
    ]
    
    
}

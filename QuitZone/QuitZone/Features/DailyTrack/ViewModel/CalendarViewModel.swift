//
//  CalendarViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 27/04/23.
//

import Foundation
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var columns = Array(repeating: GridItem(), count: 7)
    @Published var weekDaysData: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private var date: Date = Date()
    private var calendar: Calendar = Calendar.current
    private var dateComponents: DateComponents
    @Published var month: Int
    @Published var year: Int
    @Published var totalDays: Int = 0
    
    init() {
//        self.month = self.calendar.component(.month, from: self.date)
//        self.year = self.calendar.component(.year, from: self.date)
        self.dateComponents = calendar.dateComponents([.year, .month], from: self.date)
        self.month = self.dateComponents.month!
        self.year = self.dateComponents.year!
        totalDays = getTotalDaysInCurrentMonth()
    }
    
    func getTotalDaysInCurrentMonth() -> Int {
        let startOfMonth = calendar.date(from: DateComponents(year: self.year, month: self.month, day: 1))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        return range.count
    }
}

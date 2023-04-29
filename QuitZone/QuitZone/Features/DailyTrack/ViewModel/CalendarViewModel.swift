//
//  CalendarViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 27/04/23.
//

import Foundation
import CloudKit
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var totalDays: Int = 0
    @Published var daysData: [Day] = []
    @Published var month: Int = Calendar.current.component(.month, from: Date())
    @Published var year: Int = Calendar.current.component(.year, from: Date())
    @Published var spaces: Int = 0
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    private var player: Player
    
    init(player: Player) {
        self.player = player
        self.totalDays = getDaysInMonth()
        getDailyPlayerData()
        getSpacesForCalendar()
    }
    
    
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: self.year, month: self.month, day: 0)
        
        if let lastDayOfMonth = calendar.date(from: dateComponents) {
            return calendar.range(of: .day, in: .month, for: lastDayOfMonth)?.count ?? 0
        }
        return 0
    }
    
    func getDailyPlayerData() {
        let calendar = Calendar.current
        
        let startDateComponents = DateComponents(year: self.year, month: self.month, day: 1)
        let endDateComponents = DateComponents(year: self.year, month: self.month + 1, day: 1)
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: endDateComponents) else {
            return
        }
        
        let predicate = NSPredicate(format: "creationDate >= %@ AND creationDate < %@", startDate as NSDate, endDate as NSDate)
        let query = CKQuery(recordType: "DailyPlayer", predicate: predicate)
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                for i in 0..<self.totalDays {
                    let daysAndDate = self.getDaysAndDate(month: self.month, year: self.year, day: i + 1)
                    var day = Day(id: i, isFill: false, day: daysAndDate.first?.0 ?? "Null", date: daysAndDate.first?.1 ?? Date())
                    self.daysData.append(day)
                }
                for record in records {
                    let dailyPlayer = DailyPlayer(id: record.recordID ,playerID: record.value(forKey: "playerID") as! CKRecord.Reference, cigars: record.value(forKey: "cigars") as! Int, date: record.value(forKey: "date") as! Date)
                    for i in 0..<self.daysData.count {
                        if dailyPlayer.date == self.daysData[i].date {
                            self.daysData[i].isFill = true
                            self.daysData[i].dailyPlayer = dailyPlayer
                        }
                    }
                }
            }
        }
    }
    
    private func getDaysAndDate(month: Int, year: Int, day: Int) -> [(String, Date)] {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        
        let calendar = Calendar.current
        let currentDate = calendar.date(from: dateComponents)!
        
        let dayOfWeek = calendar.component(.weekday, from: currentDate)
        let nameOfDay = calendar.weekdaySymbols[dayOfWeek - 1]
        
        return [(nameOfDay, currentDate)]
    }
    
    private func getSpacesForCalendar() {
        let firstDateOfMonth = self.getDaysAndDate(month: self.month, year: self.year, day: 1)
        switch firstDateOfMonth.first?.0 {
        case "Monday":
            self.spaces = 1
        case "Tuesday":
            self.spaces = 2
        case "Wednesday":
            self.spaces = 3
        case "Thursday":
            self.spaces = 4
        case "Friday":
            self.spaces = 5
        case "Saturday":
            self.spaces = 6
        default:
            return
        }
    }
}

struct CalendarViewModelView: View {
    @ObservedObject var cvm: CalendarViewModel
    
    init(player: Player) {
        self.cvm = CalendarViewModel(player: player)
    }
    
    var body: some View {
        VStack {
            Button("getDailyPlayer") {
                cvm.getDailyPlayerData()
            }
        }
    }
}

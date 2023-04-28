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
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    private var player: Player
    private var dailyDatas: [DailyPlayer] = []
    
    init(player: Player) {
        self.player = player
        self.totalDays = getDaysInMonth()
    }
    
    
    func getDaysInMonth(month: Int? = nil, year: Int? = nil) -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        let selectedMonth = month ?? calendar.component(.month, from: date)
        let selectedYear = year ?? calendar.component(.year, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.year = selectedYear
        dateComponents.month = selectedMonth
        
        dateComponents.day = 0
        
        if let lastDayOfMonth = calendar.date(from: dateComponents) {
            return calendar.range(of: .day, in: .month, for: lastDayOfMonth)?.count ?? 0
        }
        return 0
    }
    
    func getDailyPlayerData(month: Int? = nil, year: Int? = nil) {
        let date = Date()
        let calendar = Calendar.current
        
        let selectedMonth = month ?? calendar.component(.month, from: date)
        let selectedYear = year ?? calendar.component(.year, from: date)
        
        let startDateComponents = DateComponents(year: selectedYear, month: selectedMonth, day: 1)
        let endDateComponents = DateComponents(year: selectedYear, month: selectedMonth + 1, day: 1)
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: endDateComponents) else {
            return
        }
        
        let predicate = NSPredicate(format: "creationDate >= %@ AND creationDate < %@ AND playerID == %@", startDate as NSDate, endDate as NSDate, self.player.id! as CKRecord.ID)
        let query = CKQuery(recordType: "DailyPlayer", predicate: predicate)
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                print(records)
                for record in records {
                    let dailyPlayer = DailyPlayer(id: record.recordID ,playerID: record.value(forKey: "playerID") as! CKRecord.Reference, cigars: record.value(forKey: "cigars") as! Int, date: record.value(forKey: "date") as! Date)
                    self.dailyDatas.append(dailyPlayer)
                }
                for i in 0..<self.totalDays {
                    let daysAndDate = self.getDaysAndDate(month: selectedMonth, year: selectedYear, day: i + 1)
                    var day = Day(id: i, isFill: false, day: daysAndDate.first?.0 ?? "Null", date: daysAndDate.first?.1 ?? Date())
                    if self.dailyDatas[i].date == day.date {
                        day.isFill = true
                        day.dailyPlayer = self.dailyDatas[i]
                    }
                    self.daysData.append(day)
                }
            }
        }
    }
    
    private func getDaysAndDate(month: Int, year: Int, day: Int) -> [(String, Date)] {
        var dateComponents = DateComponents(year: year, month: month, day: day)
        
        let calendar = Calendar.current
        let currentDate = calendar.date(from: dateComponents)!
        
        let dayOfWeek = calendar.component(.weekday, from: currentDate)
        let nameOfDay = calendar.weekdaySymbols[dayOfWeek - 1]
        
        return [(nameOfDay, currentDate)]
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

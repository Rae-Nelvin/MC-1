//
//  CalendarViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 27/04/23.
//

import Foundation
import CoreData

class CalendarViewModel: ObservableObject {
    
    @Published var totalDays: Int = 0
    @Published var daysData: [Day] = []
    @Published var month: Int = Calendar.current.component(.month, from: Date())
    @Published var year: Int = Calendar.current.component(.year, from: Date())
    @Published var spaces: Int = 0
    private var player: Player
    
    init(player: Player) {
        self.player = player
        self.totalDays = getDaysInMonth()
        getSpacesForCalendar()
        getMonthlyPlayerData()
    }
    
    func monthIntToString(monthInt: Int) -> String {
        var dateComponent = DateComponents()
        dateComponent.month = monthInt
        
        let currDate = Calendar(identifier: .gregorian).date(from: dateComponent)!
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        return dateFormatter.string(from: currDate)
    }
    
    func goToMonth(isMinus: Bool) {
        if isMinus {
            if self.month == 1 {
                self.month = 12
                self.year = self.year - 1
            } else {
                self.month = self.month - 1
            }
        } else {
            if self.month == 12 {
                self.month = 1
                self.year = self.year + 1
            } else {
                self.month = self.month + 1
            }
        }
        
        refreshViewModel()
    }
    
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: self.year, month: self.month, day: 0)
        
        if let lastDayOfMonth = calendar.date(from: dateComponents) {
            return calendar.range(of: .day, in: .month, for: lastDayOfMonth)?.count ?? 0
        }
        return 0
    }
    
    func createDaily(cigars: Int16?, date: Date) {
        let daily = DailyPlayer(context: PersistenceController.shared.viewContext)
        
        daily.cigars = cigars ?? 0
        daily.player = self.player
        daily.date = date
        
        PersistenceController.shared.save()
        refreshViewModel()
    }
    
    func updateDaily(cigars: Int16?, date: Date) {
        guard let daily = getDaily(date: date) else {
            return
        }
        
        daily.cigars = cigars ?? 0
        
        PersistenceController.shared.save()
        refreshViewModel()
    }
    
    private func getDaily(date: Date) -> DailyPlayer? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let request: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        request.predicate = NSPredicate(format: "player == %@ AND date >= %@ AND date < %@", self.player, startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            return results.first ?? DailyPlayer()
        } catch let error as NSError {
            print("Error fetching records : \(error)")
            return nil
        }
    }
    
    func getMonthlyPlayerData() {
        let calendar = Calendar.current
        
        let startDateComponents = DateComponents(year: self.year, month: self.month, day: 1)
        let endDateComponents = DateComponents(year: self.year, month: self.month + 1, day: 1)
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: endDateComponents) else {
            return
        }
        
        let request: NSFetchRequest<DailyPlayer> = DailyPlayer.fetchRequest()
        request.predicate = NSPredicate(format: "player == %@ AND date >= %@ AND date < %@", self.player, startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            for i in 0..<self.totalDays {
                let daysAndDate = self.getDaysAndDate(month: self.month, year: self.year, day: i + 1)
                let day = Day(id: i, isFill: false, cigars: 0, date: daysAndDate.first?.1 ?? Date())
                self.daysData.append(day)
            }
            for result in results {
                let dailyPlayer: DailyPlayer = result
                for i in 0..<self.daysData.count {
                    if self.stripDate(from: dailyPlayer.date!) == self.stripDate(from: self.daysData[i].date) {
                        self.daysData[i].isFill = true
                        self.daysData[i].cigars = result.cigars
                        self.daysData[i].dailyPlayer = result
                    }
                }
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
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
    
    private func refreshViewModel() {
        self.totalDays = getDaysInMonth()
        getSpacesForCalendar()
        self.daysData = []
        getMonthlyPlayerData()
    }
    
    private func stripDate(from date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)
    }
}

//
//  CalendarHelper.swift
//  QuitZone
//
//  Created by ndyyy on 28/04/23.
//

import Foundation

struct CalendarHelper {
    var calendar = Calendar.current
    
    func getItemDate(day: Int, currAppDate: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = calendar.component(.month, from: currAppDate)
        dateComponents.year = calendar.component(.year, from: currAppDate)
        dateComponents.hour = calendar.component(.hour, from: currAppDate)
        dateComponents.minute = calendar.component(.minute, from: currAppDate)
        dateComponents.timeZone = TimeZone(identifier: "id-ID")
        
        let itemCalendar = Calendar(identifier: .gregorian)
        return itemCalendar.date(from: dateComponents)!
    }
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    //full month = LLLL, year = yyyy
    func getCalendarComponentString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func totalDaysInMonth(date: Date) -> Int {
        let days = calendar.range(of: .day, in: .month, for: date)!
        return days.count
    }
    
    //ex output from: 2 jan 2021 -> 2
    func dayOfMonth(date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func firstWeekDayOfMonth(date: Date) -> Int {
        let component = calendar.dateComponents([.year, .month], from: date)
        let firstOfMonthDate = calendar.date(from: component)!
        return calendar.component(.weekday, from: firstOfMonthDate) - 1
    }
    
    func showStatLastSevenDays(progressData: [ProgressModel]) -> [ProgressModel] {
        var progressDataByDate: [ProgressModel] = []
        let sevenDaysInt = Calendar.current.component(.day, from: Date()) - 7
        let sevenDaysAgoDate = CalendarHelper().getItemDate(day: sevenDaysInt, currAppDate: Date())
        
        for data in progressData {
            if data.date >= sevenDaysAgoDate && data.date <= Date() {
                progressDataByDate.append(data)
            }
        }
        return progressDataByDate
    }
    
    func showStatThisMonth(progressData: [ProgressModel]) -> [ProgressModel] {
        var progressDataByDate: [ProgressModel] = []
        let currMonth = Calendar.current.component(.month, from: Date())
        let currYear = Calendar.current.component(.year, from: Date())
        
        for data in progressData {
            let dataMonth = Calendar.current.component(.month, from: data.date)
            let dataYear = Calendar.current.component(.year, from: data.date)
            
            if dataMonth == currMonth && dataYear == currYear {
                progressDataByDate.append(data)
            }
        }
        return progressDataByDate
    }
    
    func showCalendarData(currProgressDate: Date) -> [String] {
        var daysData: [String] = []
        
        //April contains 30 days (Int)
        let totalDays = totalDaysInMonth(date: currProgressDate)
        
        //1 April = 6 (Saturday, means we want to empty space from sun to fri)
        let startingSpace = firstWeekDayOfMonth(date: currProgressDate)
        
        var ctrItem: Int = 1
        //empty space have 42 box
        while(ctrItem <= 42) {
            if ctrItem <= startingSpace || (ctrItem - startingSpace) > totalDays {
                daysData.append("")
            } else {
                daysData.append(String(ctrItem - startingSpace))
            }
            
            ctrItem += 1
        }
        return daysData
    }
    
    //MARK: to find a cigarette from our model with itemDate
    func findCigInProgressData(itemDate: Date, progressData: [ProgressModel]) -> Int {
        for progress in progressData {
            if itemDate == progress.date {
                return progress.cigarettes
            }
        }
        return -1
    }
    
}

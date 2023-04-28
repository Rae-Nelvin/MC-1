//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI
import Charts

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

struct HomeComponent: View {
    
    @State var currPicker = "7 Days"
    @State var progressDataByDate: [ProgressModel] = []
    @State var progressData: [ProgressModel] = [
        ProgressModel(date: CalendarHelper().getItemDate(day: 20, currAppDate: Date()), cigarettes: 5),
        ProgressModel(date: CalendarHelper().getItemDate(day: 21, currAppDate: Date()), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 22, currAppDate: Date()), cigarettes: 3),
        ProgressModel(date: CalendarHelper().getItemDate(day: 23, currAppDate: Date()), cigarettes: 4),
        ProgressModel(date: CalendarHelper().getItemDate(day: 24, currAppDate: Date()), cigarettes: 1),
        ProgressModel(date: CalendarHelper().getItemDate(day: 25, currAppDate: Date()), cigarettes: 2)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Quit Zone")
                .customText(size:36)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("Lungs")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            
            //progress
            VStack {
                Text("**Progress**")
                    .customText(size: 24)
                    .hAlign(.leading)
                    .padding(.bottom, 15)
                    .padding(.top, 30)
                
                //MARK: Calendar Progress View
                CalendarView(progressData: $progressData,
                             progressDataByDate: $progressDataByDate)
                
                //MARK: Statistics
                VStack {
                    //MARK: Statistics Selection
                    HStack {
                        Text("**Statistics**")
                            .customText(size: 24)
                            .hAlign(.leading)
                        
                        Spacer()
                        
                        Picker("", selection: $currPicker) {
                            Text("Last 7 Days").tag("7 Days")
                            Text("This Month").tag("Month")
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 200)
                    }
                    
                    //MARK: Show statistics chart
                    statisticsChart()
                }
                .onChange(of: currPicker) {tabName in
                    progressDataByDate.removeAll()
                    if tabName == "7 Days" {
                        progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
                    }
                    else if tabName == "Month" {
                        progressDataByDate = CalendarHelper().showStatThisMonth(progressData: progressData)
                    }
                }
                .onAppear {
                    progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
                }
                .padding(.top, 30)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func statisticsChart() -> some View {
        
        let yAxisCigarettes = progressData.max {x, y in
            return x.cigarettes < y.cigarettes
        }!.cigarettes
        
        let yAxisTar = progressData.max {x, y in
            return x.tarConsume < y.tarConsume
        }!.tarConsume
        
        let yAxisNicotine = progressData.max {x, y in
            return Int(x.nicotineConsume) < Int(y.nicotineConsume)
        }!.nicotineConsume
        
        
        //MARK: Cigarettes
        VStack(alignment: .leading) {
            Text("**Cigarette**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Cigarettes", data.cigarettes)
                )
            }
            .chartYScale(domain: 0...yAxisCigarettes + 5)
            .frame(width: 300, height: 150)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white.shadow(.drop(radius: 5)))
        )
        .padding(.top, 15)
        
        //MARK: Tar
        VStack(alignment: .leading) {
            Text("**Tar**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Cigarettes", data.tarConsume)
                )
            }
            .chartYScale(domain: 0...yAxisTar + 50)
            .frame(width: 300, height: 150)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white.shadow(.drop(radius: 5)))
        )
        .padding(.top, 15)
        
        //MARK: Nicotine
        VStack(alignment: .leading) {
            Text("**Nicotine**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Nicotine", Int(data.nicotineConsume))
                )
            }
            .chartYScale(domain: 0...yAxisNicotine + 3)
            .frame(width: 300, height: 150)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white.shadow(.drop(radius: 5)))
        )
        .padding(.top, 15)
        
        
    }
}

struct CalendarView: View {
    let columns = Array(repeating: GridItem(), count:7)
    let weekDaysData: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State var currProgressDate = Date()
    @State var daysData: [String] = []
    @Binding var progressData: [ProgressModel]
    @Binding var progressDataByDate: [ProgressModel]

    var body: some View {
        VStack {
            //MARK: Calendar Navigation
            HStack {
                //left button
                Button {
                    currProgressDate = CalendarHelper().minusMonth(date: currProgressDate)
                    DispatchQueue.main.async {
//                        showCalendarData()
                        daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                    }
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                //Month & Year
                HStack {
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currProgressDate, format: "LLLL")
                    )
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currProgressDate, format: "yyyy")
                    )
                }
                .frame(width: 200)
                
                //right button
                Button {
                    currProgressDate = CalendarHelper().plusMonth(date: currProgressDate)
                    DispatchQueue.main.async {
//                        showCalendarData()
                        daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                    }
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            .padding(.bottom, 30)
            
            //MARK: Calendar Data
            LazyVGrid(columns: columns) {
                //MARK: WeekDays
                ForEach(weekDaysData, id: \.self) {day in
                    Text(day)
                        .hAlign(.center)
                        .padding(.trailing, 5)
                }
                
                //MARK: Day Section
                ForEach(daysData.indices, id:\.self) {x in
                    
                    let boxItem = daysData[x]
                    
                    //get the current item date (1 is random number that I generate to handle error in empty boxItem)
                    let itemDate = CalendarHelper().getItemDate(day: Int(boxItem) ?? 1, currAppDate: currProgressDate)
                    
                    //get cigarettes data from itemDate
                    let cigarettesData: Int = findCigInProgressData(itemDate: itemDate)
                    
                    //show cigarettes data in box
                    let showCigarettes: Bool = (cigarettesData != -1) ? true : false
                    
                    //used to block input from user in date greater than today
                    let fillData: Bool = itemDate <= Date()
                    
                    //MARK: Day
                    VStack {
                        Text(boxItem)
                            .padding(.bottom, -5)
                        //MARK: Cigarettes box
                        if boxItem != "" {
                            Text(showCigarettes ? String(cigarettesData) : " ")
                                .frame(width: 35, height: 35)
                                .background(
                                    Rectangle()
                                        .fill(fillData ? .gray.opacity(0.8): .gray.opacity(0.1))
                                        .background(
                                            Rectangle()
                                                .stroke()
                                        )
                                )
                                .padding(-1)
                        }
                    }
                    .onTapGesture {
                        //format date
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMMM yyyy"
                        let itemDateString = dateFormatter.string(from: itemDate)
                        
                        //testing
                        print("")
                        print("item date: \(itemDate)")
                        print("date now: \(Date())")
                        print("fill data: \(fillData)")
                        print("cig data: \(cigarettesData)")
                        print("show cig: \(showCigarettes)")
                        print("")
                        print("")
                        
                        //alert only show for item <= today date
                        if fillData {
                            customAlertTextField(title: itemDateString,
                                                 message: "Number of cigarettes",
                                                 leftButton: "Cancel",
                                                 rightButton: "Save") {
                                print("Cancelled")
                            } rightAction: { text in
                                //add new data
                                let newData = ProgressModel(date: itemDate, cigarettes: Int(text)!)
                                progressData.append(newData)
                                
                                print("New data saved: \(text) with date \(itemDate)")
                                
                                //refresh calendar to see update
//                                showCalendarData()
                                daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                                progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
                            }
                        }
                    }
                    .hAlign(.center)
                    .padding(1)
                }
                
            }
            .hAlign(.center)
        }
        .onAppear {
//            showCalendarData()
            daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
        }
        
    }
    
    //MARK: to find a cigarette from our model with itemDate
    func findCigInProgressData(itemDate: Date) -> Int {
        for progress in progressData {
            if itemDate == progress.date {
                return progress.cigarettes
            }
        }
        return -1
    }
    
//    func showCalendarData() {
//        daysData.removeAll()
//
//        //April contains 30 days (Int)
//        let totalDays = CalendarHelper().totalDaysInMonth(date: currProgressDate)
//
//        //1 April = 6 (Saturday, means we want to empty space from sun to fri)
//        let startingSpace = CalendarHelper().firstWeekDayOfMonth(date: currProgressDate)
//
//        var ctrItem: Int = 1
//        //empty space have 42 box
//        while(ctrItem <= 42) {
//            if ctrItem <= startingSpace || (ctrItem - startingSpace) > totalDays {
//                daysData.append("")
//            } else {
//                daysData.append(String(ctrItem - startingSpace))
//            }
//
//            ctrItem += 1
//        }
//    }
}

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
    
}

struct HomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeComponent()
    }
}

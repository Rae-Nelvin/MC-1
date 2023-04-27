//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI
import Charts

struct ChartModel: Identifiable {
    let id = UUID()
    let date: Date
    var cigarettes: Int
    
    //patokan: Sampoerna
    private let nicotine = 0.8
    private let tar = 12
    private let price = 2000
    
    init(cigarettes : Int, dateString: String) {
        let formattedDate = DateFormatter()
        formattedDate.dateFormat = "ddMMyyyy"
        formattedDate.locale = Locale(identifier: "id_ID")
        formattedDate.timeZone = TimeZone.current
  
        self.cigarettes = cigarettes
        self.date = formattedDate.date(from: dateString) ?? Date()
    }
    
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
    @State var sampleAnalyticsByDate: [ChartModel] = []
    @State var progressData: [ProgressModel] = []
    
    let sampleAnalytics: [ChartModel] = [
        ChartModel(cigarettes: 3, dateString: "01042022"),
        ChartModel(cigarettes: 4, dateString: "02042022"),
        ChartModel(cigarettes: 1, dateString: "03042022"),
        ChartModel(cigarettes: 6, dateString: "14042023"),
        ChartModel(cigarettes: 3, dateString: "05042023"),
        ChartModel(cigarettes: 2, dateString: "19042023"),
        ChartModel(cigarettes: 6, dateString: "20042023"),
        ChartModel(cigarettes: 3, dateString: "21042023"),
        ChartModel(cigarettes: 3, dateString: "22042023"),
        ChartModel(cigarettes: 3, dateString: "24042023")
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Quit Zone")
                //.customText(size:36)
                //.font(.dogica(.bold))
                .font(.custom("dogica", size:36))
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
                CalendarView(progressData: $progressData)
                
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
                    sampleAnalyticsByDate.removeAll()
                    if tabName == "7 Days" {
                        last7Days()
                    }
                    else if tabName == "Month" {
                        showMonths()
                    }
                }
                .onAppear {
                    last7Days()
                }
                .padding(.top, 30)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func statisticsChart() -> some View {
        
        let yAxisCigarettes = sampleAnalytics.max {x, y in
            return x.cigarettes < y.cigarettes
        }!.cigarettes
        
        let yAxisTar = sampleAnalytics.max {x, y in
            return x.tarConsume < y.tarConsume
        }!.tarConsume

        let yAxisNicotine = sampleAnalytics.max {x, y in
            return Int(x.nicotineConsume) < Int(y.nicotineConsume)
        }!.nicotineConsume
        
        
        //MARK: Cigarettes
        VStack(alignment: .leading) {
            Text("**Cigarette**")
            Chart(sampleAnalyticsByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Cigarettes", data.cigarettes)
                )
            }
            .chartYScale(domain: 0...yAxisCigarettes + 10)
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
            Chart(sampleAnalyticsByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Cigarettes", data.tarConsume)
                )
            }
            .chartYScale(domain: 0...yAxisTar + 100)
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
            Chart(sampleAnalyticsByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Nicotine", Int(data.nicotineConsume))
                )
            }
            .chartYScale(domain: 0...yAxisNicotine + 5)
            .frame(width: 300, height: 150)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white.shadow(.drop(radius: 5)))
        )
        .padding(.top, 15)
        
        
    }
    
    func last7Days() {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())

        for data in sampleAnalytics {
            if data.date >= sevenDaysAgo! && data.date <= Date() {
                sampleAnalyticsByDate.append(data)
            }
        }
    }
    
    func showMonths() {
        let currMonth = Calendar.current.component(.month, from: Date())
        let currYear = Calendar.current.component(.year, from: Date())
    
        for data in sampleAnalytics {
            let dataMonth = Calendar.current.component(.month, from: data.date)
            let dataYear = Calendar.current.component(.year, from: data.date)
            
            if dataMonth == currMonth && dataYear == currYear {
                sampleAnalyticsByDate.append(data)
            }
        }
    }
}

struct CalendarView: View {
    let columns = Array(repeating: GridItem(), count:7)
    let weekDaysData: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State var currDate = Date()
    @State var daysData: [String] = []
    @Binding var progressData: [ProgressModel]
    
    var body: some View {
        VStack {
            //MARK: Calendar Navigation
            HStack {
                //left button
                Button {
                    currDate = CalendarHelper().minusMonth(date: currDate)
                    showCalendarData()
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                //Month & Year
                HStack {
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currDate, format: "LLLL")
                    )
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currDate, format: "yyyy")
                    )
                }
                .padding(.horizontal, 40)
                
                //right button
                Button {
                    currDate = CalendarHelper().plusMonth(date: currDate)
                    showCalendarData()
                } label: {
                    Image(systemName: "arrow.right")
                }
                
            }
            .padding(.bottom, 30)
    
            //MARK: Calendar Data
            LazyVGrid(columns: columns) {
                ForEach(weekDaysData, id: \.self) {day in
                    Text(day)
                        .hAlign(.center)
                        .padding(.trailing, 5)
                }

                ForEach(daysData, id:\.self) {item in
                    //if item is "", make fillData is false using date greater than today / today + 1
                    let nextDay = Calendar.current.component(.day, from: Date()) + 1

                    //get the current item date
                    let itemDate = getItemDate(day: Int(item) ?? nextDay, currDate: currDate)
                    let fillData: Bool = itemDate <= Date()
                    
                    VStack {
                        Text(item)
                            .padding(.bottom, -5)
                        if item != "" {
                            Text("1")
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
                        
                        //alert only show for item <= today date
                        if fillData {
                            customAlertTextField(title: itemDateString, message: "Number of cigarettes", leftButton: "Cancel", rightButton: "Save") {
                                print("Cancelled")
                            } rightAction: { text in
                                //add new data
                                let newData = ProgressModel(date: itemDate, cigarettes: Int(text)!)
                                progressData.append(newData)
                                
                                print("New data saved: \(text)")
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
            showCalendarData()
        }
        
    }

    func getItemDate(day: Int, currDate: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = Calendar.current.component(.month, from: currDate)
        dateComponents.year = Calendar.current.component(.year, from: currDate)
        dateComponents.hour = Calendar.current.component(.hour, from: currDate)
        dateComponents.minute = Calendar.current.component(.minute, from: currDate)
        dateComponents.timeZone = TimeZone(identifier: "id-ID")
        
        
        let itemCalendar = Calendar(identifier: .gregorian)
        return itemCalendar.date(from: dateComponents)!
    }
    
    func showCalendarData() {
        daysData.removeAll()
        
        //April contains 30 days (Int)
        let totalDays = CalendarHelper().totalDaysInMonth(date: currDate)
        
        //1 April = 6 (Saturday, means we want to empty space from sun to fri)
        let startingSpace = CalendarHelper().firstWeekDayOfMonth(date: currDate)
        
        
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
    }
}

struct CalendarHelper {
    var calendar = Calendar.current
    
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
    
//    func firstOfMonth(date: Date) -> Date {
//        let component = calendar.dateComponents([.year, .month], from: date)
//        return calendar.date(from: component)!
//    }
//
//    //ex output from: Tue, 25 Apr 2022 -> 3 (because Sun, Mon, Tue)
//    func weekDay(date: Date) -> Int {
//        //subtract 1 to give empty space
//        return calendar.component(.weekday, from: date) - 1
//    }
    
    func firstWeekDayOfMonth(date: Date) -> Int {
        let component = calendar.dateComponents([.year, .month], from: date)
        let firstOfMonthDate = calendar.date(from: component)!
        return calendar.component(.weekday, from: firstOfMonthDate) - 1
    }
    
}

struct HomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeComponent()
    }
}


//MARK: Some Testing Code
/**
 
 //to get the total
 let total = sample_analytics.reduce(0.0) { partialResult, item in
     Double(item.cigarettes) + partialResult
 }
 struct CalendarView: UIViewRepresentable {
     func updateUIView(_ uiView: UICalendarView, context: Context) {
         
     }
     
     func makeUIView(context: Context) -> UICalendarView {
         let view = UICalendarView()
         view.calendar = Calendar(identifier: .gregorian)
         //        view.availableDateRange
         return view
     }
 }

 
 
 */

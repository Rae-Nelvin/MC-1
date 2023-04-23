//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI
import Charts

struct HomeComponent: View {
    
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
                
                CalendarView()
                    .padding([.horizontal, .vertical], -10)
            }
            
            .padding(.top, 50)
            
            //bar chart
            VStack {
                Text("Statistics")
                    .customText(size: 24)
                    .hAlign(.leading)
                GroupBox("Cigarettes") {
                    Chart(testData()) { data in
                        BarMark (
                            x: .value("Date", data.date, unit: .day),
                            y: .value("Cigarettes", data.cigarettes)
                        )
                    }
                }
                GroupBox("Tar Consumed") {
                    Chart(testData()) {data in
                        BarMark (
                            x: .value("Date", data.date, unit: .day),
                            y: .value("Tar Consume", data.tarConsume)
                        )
                    }
                }
                GroupBox("Nicotine Consumed") {
                    Chart(testData()) {data in
                        BarMark (
                            x: .value("Date", data.date, unit: .day),
                            y: .value("Nicotine Consume", Int(exactly: data.nicotineConsume)!)
                            
                        )
                    }
                }
            }
        }
        .padding()
    }
}

struct exampleChartModel: Identifiable {
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

func testData() -> [exampleChartModel] {
    let data: [exampleChartModel] = [
        exampleChartModel(cigarettes: 10, dateString: "02032022"),
        exampleChartModel(cigarettes: 10, dateString: "03032022"),
        exampleChartModel(cigarettes: 10, dateString: "04032022"),
        exampleChartModel(cigarettes: 10, dateString: "05032022"),
        exampleChartModel(cigarettes: 10, dateString: "09032022"),
        exampleChartModel(cigarettes: 10, dateString: "03032022"),
        exampleChartModel(cigarettes: 10, dateString: "04032022"),
        exampleChartModel(cigarettes: 10, dateString: "05032022")
        
    ]
    
    return data
}

struct CalendarView: UIViewRepresentable {
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    //    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        //        view.availableDateRange
        return view
    }
}

struct HomeComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeComponent()
    }
}

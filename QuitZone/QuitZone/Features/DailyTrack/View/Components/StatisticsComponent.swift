//
//  StatisticsView.swift
//  QuitZone
//
//  Created by ndyyy on 28/04/23.
//

import SwiftUI
import Charts

struct StatisticsComponent: View {
    @Binding var progressData: [ProgressModel]
    @Binding var progressDataByDate: [ProgressModel]
    
    var body: some View {
        //MARK: Cigarettes
        VStack(alignment: .leading) {
            Text("**Cigarette**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Cigarettes", data.cigarettes)
                )
            }
            .chartYScale(domain: 0...StatisticsHelper(progressData: progressData).yAxisCigarettes() + 5)
            .frame(width: 300, height: 150)
        }
        .statisticsFormating()
        
        //MARK: Tar
        VStack(alignment: .leading) {
            Text("**Tar**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Tar", data.tarConsume)
                )
            }
            .chartYScale(domain: 0...StatisticsHelper(progressData: progressData).yAxisTar() + 50)
            .frame(width: 300, height: 150)
        }
        .statisticsFormating()
        
        //MARK: Nicotine
        VStack(alignment: .leading) {
            Text("**Nicotine**")
            Chart(progressDataByDate) { data in
                BarMark (
                    x: .value("Date", data.date, unit: .day),
                    y: .value("Nicotine", Int(data.nicotineConsume))
                )
            }
            .chartYScale(domain: 0...StatisticsHelper(progressData: progressData).yAxisNicotine() + 5)
            .frame(width: 300, height: 150)
        }
        .statisticsFormating()
    }
}

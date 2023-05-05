 //
//  TarComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 03/05/23.
//

import SwiftUI
import Charts

struct TarComponent: View {
    @Binding var progressData: [ProgressModel]
    @Binding var progressDataByDate: [ProgressModel]
    
    var body: some View {
        //MARK: Tar
        VStack(alignment: .leading) {
            Text("**Tar Last 7 Days**")
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
    }
}

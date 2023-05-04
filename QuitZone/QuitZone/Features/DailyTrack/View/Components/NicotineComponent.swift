//
//  TarComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 03/05/23.
//

import SwiftUI
import Charts

struct NicotineComponent: View {
    @Binding var progressData: [ProgressModel]
    @Binding var progressDataByDate: [ProgressModel]
    
    var body: some View {
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

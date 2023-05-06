//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct HomeComponents: View {
    @ObservedObject private var dpvm: DailyPlayerViewModel
    
    init(player: Player) {
        self.dpvm = DailyPlayerViewModel(player: player)
    }
    
    var body: some View {
        VStack {
            //MARK: 3 button
            HStack {
                //MARK: Nicotine
                ProgressBarComponent(percentage: 57, tickValue: 320, showText: true)
                    .onTapGesture {
                        dpvm.showSheetContentStatus = .nicotine
                        dpvm.sheetStatus.toggle()
                    }
                
                //MARK: Tar
                ProgressBarComponent(percentage: 75, tickValue: 14, showText: true)
                    .onTapGesture {
                        dpvm.showSheetContentStatus = .tar
                        dpvm.sheetStatus.toggle()
                    }
                
                //MARK: Calendar
                ZStack {
                    ProgressBarComponent(percentage: 100, tickValue: 40, showText: false)
                    Image(systemName:"calendar")
                        .font(.largeTitle)
                }
                .onTapGesture {
                    dpvm.showCalendar.toggle()
                    dpvm.fetchDailyPlayer()
                }
            }
            .hAlign(.top)
            .padding(.bottom, 16)
            
            Spacer()
            
            VStack {
                //MARK: Calendar
                if dpvm.showCalendar {
                    CalendarComponent(player: dpvm.player)
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                        .background(Color.white.opacity(0.5))
                    
                    Spacer()
                }
                else {
                    //MARK: Lung
                    VStack {
                        LungsComponent(lung: self.dpvm.player.lungCondition ?? "lunglvl1")
                            .padding(.bottom, 28)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
            .background(
                Image("humanBody")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: dpvm.showCalendar ? 3 : 0)
            )
            .sheet(isPresented: $dpvm.sheetStatus) {
                switch dpvm.showSheetContentStatus {
                    case .nicotine:
                    NicotineComponent(progressData: $dpvm.progressData, progressDataByDate: $dpvm.progressDataByDate)
                            .presentationDetents([.height(250)])
                            .presentationDragIndicator(.visible)
                    case .tar:
                    TarComponent(progressData: $dpvm.progressData, progressDataByDate: $dpvm.progressDataByDate)
                            .presentationDetents([.height(250)])
                            .presentationDragIndicator(.visible)
                }
            }
            .onAppear {
                dpvm.progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: dpvm.progressData)
            }
        }
    }
}

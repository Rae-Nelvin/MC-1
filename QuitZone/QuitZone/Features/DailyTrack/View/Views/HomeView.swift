//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = TestSheetViewModel()
    
    var body: some View {
        VStack {
            //MARK: 3 button
            HStack {
                //MARK: Nicotine
                ProgressBarComponent(percentage: 57, tickValue: 320, showText: true)
                    .onTapGesture {
                        vm.showSheetContentStatus = .nicotine
                        vm.sheetStatus.toggle()
                    }
                
                //MARK: Tar
                ProgressBarComponent(percentage: 75, tickValue: 14, showText: true)
                    .onTapGesture {
                        vm.showSheetContentStatus = .tar
                        vm.sheetStatus.toggle()
                    }
                
                //MARK: Calendar
                ZStack {
                    ProgressBarComponent(percentage: 100, tickValue: 40, showText: false)
                    Image(systemName:"calendar")
                        .font(.largeTitle)
                }
                .onTapGesture {
                    vm.showCalendar.toggle()
                }
            }
            .hAlign(.top)
            .padding(.bottom, 16)
            
            Spacer()
            
            VStack {
                //MARK: Calendar
                if vm.showCalendar {
                    CalendarComponent(progressData: $vm.progressData,
                                      progressDataByDate: $vm.progressDataByDate)
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                        .background(Color.white.opacity(0.5))
                    Spacer()
                }
                else {
                    //MARK: Lung
                    VStack {
                        LungsComponent()
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
                    .blur(radius: vm.showCalendar ? 3 : 0)
            )
            .sheet(isPresented: $vm.sheetStatus) {
                switch vm.showSheetContentStatus {
                    case .nicotine:
                    NicotineComponent(progressData: $vm.progressData, progressDataByDate: $vm.progressDataByDate)
                            .presentationDetents([.height(250)])
                            .presentationDragIndicator(.visible)
                    case .tar:
                    TarComponent(progressData: $vm.progressData, progressDataByDate: $vm.progressDataByDate)
                            .presentationDetents([.height(250)])
                            .presentationDragIndicator(.visible)
                }
            }
            .onAppear {
                vm.progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: vm.progressData)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//            //MARK: Lungs
//            LungsComponent()

//            //MARK: Progress
//            VStack {
//                Text("**Progress**")
//                    .font(.secondary(.custom(24)))
//                    .hAlign(.leading)
//                    .padding(.bottom, 15)
//                    .padding(.top, 30)

//                //MARK: Calendar Progress View
//                CalendarComponent(progressData: $progressData,
//                                  progressDataByDate: $progressDataByDate)
//            }
//            //MARK: Statistics
//            VStack {
//                //MARK: Statistics Selection
//                HStack {
//                    Text("**Statistics**")
//                        .font(.secondary(.custom(24)))
//                        .hAlign(.leading)
//
//                    Spacer()
//
//                    Picker("", selection: $currPicker) {
//                        Text("Last 7 Days").tag("7 Days")
//                        Text("This Month").tag("Month")
//                    }
//                    .pickerStyle(.segmented)
//                    .frame(width: 200)
//                }
//
//                //MARK: Show statistics chart
//                StatisticsComponent(progressData: $progressData, progressDataByDate: $progressDataByDate)
//            }
//            .onChange(of: currPicker) {tabName in
//                progressDataByDate.removeAll()
//                if tabName == "7 Days" {
//                    progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
//                }
//                else if tabName == "Month" {
//                    progressDataByDate = CalendarHelper().showStatThisMonth(progressData: progressData)
//                }
//            }
//            .onAppear {
//                progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
//            }
//            .padding(.top, 30)

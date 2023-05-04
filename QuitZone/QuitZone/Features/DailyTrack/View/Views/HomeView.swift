//
//  HomeComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var currPicker = "7 Days"
    @State var progressDataByDate: [ProgressModel] = []
    @State var progressData: [ProgressModel] = [
        ProgressModel(date: CalendarHelper().getItemDate(day: 1, currAppDate: Date()), cigarettes: 5),
        ProgressModel(date: CalendarHelper().getItemDate(day: 2, currAppDate: Date()), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 3, currAppDate: Date()), cigarettes: 3),
        ProgressModel(date: CalendarHelper().getItemDate(day: 4, currAppDate: Date()), cigarettes: 6),
        ProgressModel(date: CalendarHelper().getItemDate(day: 5, currAppDate: Date()), cigarettes: 1),
        ProgressModel(date: CalendarHelper().getItemDate(day: 29, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 30, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 3)
    ]
    
    @ObservedObject var vm = TestSheetViewModel()
    
    @State var showCalendar : Bool = false
    
    
    var body: some View {
        VStack {
            //MARK: 3 button
            HStack {
                ProgressBar(percentage: 57, tickValue: 320, showText: true) //Nikotin
                    .onTapGesture {
                        vm.showSheetContentStatus = .nicotine
                        vm.sheetStatus.toggle()
                    }
                
                ProgressBar(percentage: 75, tickValue: 14, showText: true) //Tar
                    .onTapGesture {
                        vm.showSheetContentStatus = .tar
                        vm.sheetStatus.toggle()
                    }
                
                ZStack {
                    ProgressBar(percentage: 100, tickValue: 40, showText: false) //Kalender
                    Image(systemName:"calendar")
                        .font(.largeTitle)
                }
                .onTapGesture {
                    showCalendar.toggle()
                }
            }
            .hAlign(.top)
            .padding(.bottom, 16)
            
            Spacer()
            
            ZStack {
                VStack {
                    if showCalendar {
                        //MARK: Calendar
                        CalendarComponent(progressData: $progressData, progressDataByDate: $progressDataByDate, currPicker: $currPicker)
                            .zIndex(1)
                            .padding(.top, 50)
                            .padding(.horizontal, 16)
                            .background(Color.white.opacity(0.5))
                        Spacer()
                    }
                    else {
                        VStack {
                            LungsComponent()
                                .padding(.bottom, 28)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .blur(radius: showCalendar ? 1 : 0)
                        
                        
                    }
                    
                }
            }
            .background(
                Image("humanBody")
                    .resizable()
                    .scaledToFit()
            )
            .sheet(isPresented: $vm.sheetStatus) {
                switch vm.showSheetContentStatus {
                case .nicotine:
                    NicotineComponent(progressData: $progressData, progressDataByDate: $progressDataByDate)
                        .presentationDetents([.height(250)])
                        .presentationDragIndicator(.visible)
                case .tar:
                    TarComponent(progressData: $progressData, progressDataByDate: $progressDataByDate)
                        .presentationDetents([.height(250)])
                        .presentationDragIndicator(.visible)
                }
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

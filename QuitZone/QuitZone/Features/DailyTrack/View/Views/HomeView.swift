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

//
//  CalendarComponent.swift
//  QuitZone
//
//  Created by ndyyy on 28/04/23.
//

import SwiftUI

struct CalendarComponent: View {
    
    @ObservedObject private var cvm: CalendarViewModel
    let columns = Array(repeating: GridItem(), count:7)
    let weekDaysData: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var spacesRange: Range<Int> {
        return 0..<cvm.spaces
    }
    
    init(player: Player){
        self.cvm = CalendarViewModel(player: player)
    }
    
    var body: some View {
        VStack {
            //MARK: Calendar Navigation
            HStack {
                //left button
                Button {
                    cvm.goToMonth(isMinus: true)
                } label: {
                    Image("ButtonLeft")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                //Month & Year
                HStack {
                    Text(String(cvm.monthIntToString(monthInt: cvm.month)))
                        .font(.secondary(.custom(24)))
                    Text(String(cvm.year))
                        .font(.secondary(.custom(24)))
                }
                .frame(width: 200)
                
                //right button
                Button {
                    cvm.goToMonth(isMinus: false)
                } label: {
                    Image("ButtonRight")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.bottom, 30)
            
            LazyVGrid(columns: columns, content: {
                ForEach(weekDaysData, id: \.self) { weekDay in
                    Text(weekDay)
                        .hAlign(.center)
                        .padding(.trailing, 5)
                        .font(.secondary(.custom(22)))
                }
                ForEach(spacesRange, id: \.self) { space in
                    Text("")
                        .hAlign(.center)
                        .padding(.trailing, 5)
                }
                ForEach(cvm.daysData, id: \.id) { day in
                    if day.isFill {
                        VStack {
                            Text("\(day.id + 1)")
                                .padding(.bottom, -5)
                            Text(day.cigars > 0 ? String(day.cigars) : " ")
                                .frame(width: 35, height: 35)
                                .background( Image("CalendarTickFill")
                                    .resizable()
                                    .scaledToFit()
                                    .onTapGesture {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd MMMM yyyy"
                                        let itemDateString = dateFormatter.string(from: day.date)
                                        customAlertTextField(title: itemDateString, message: "Number of Cigarattes", leftButton: "Cancel", rightButton: "Save") {
                                            print("Canceled")
                                        } rightAction: { cigar in
                                            cvm.updateDaily(cigars: Int16(cigar), date: day.date)
                                        }
                                    })
                        }
                    } else if day.date > Date() {
                        VStack {
                            Text("\(day.id + 1)")
                                .padding(.bottom, -5)
                            Text(" ")
                                .frame(width: 35, height: 35)
                                .background( Image("CalendarTickUnFill")
                                    .resizable()
                                    .scaledToFit()
                                    .onTapGesture {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd MMMM yyyy"
                                        let itemDateString = dateFormatter.string(from: day.date)
                                        customAlertTextField(title: itemDateString, message: "Number of Cigarattes", leftButton: "Cancel", rightButton: "Save") {
                                            print("Canceled")
                                        } rightAction: { cigar in
                                            cvm.updateDaily(cigars: Int16(cigar), date: day.date)
                                        }
                                    })
                        }
                    } else {
                        VStack {
                            Text("\(day.id + 1)")
                                .padding(.bottom, -5)
                            Text(" ")
                                .frame(width: 35, height: 35)
                                .background( Image("CalendarTickUnFill")
                                    .resizable()
                                    .scaledToFit()
                                    .onTapGesture {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "dd MMMM yyyy"
                                        let itemDateString = dateFormatter.string(from: day.date)
                                        customAlertTextField(title: itemDateString, message: "Number of Cigarattes", leftButton: "Cancel", rightButton: "Save") {
                                            print("Canceled")
                                        } rightAction: { cigar in
                                            cvm.updateDaily(cigars: Int16(cigar), date: day.date)
                                        }
                                    })
                        }
                    }
                }
            })
            .hAlign(.center)
        }
        
    }
}

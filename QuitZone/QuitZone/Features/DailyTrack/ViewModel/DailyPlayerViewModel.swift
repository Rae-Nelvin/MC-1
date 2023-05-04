//
//  DailyPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import CloudKit

class DailyPlayerViewModel: ObservableObject {
    
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    
    func createDaily(playerID: CKRecord.ID, cigars: Int?) {
        let record = CKRecord(recordType: "DailyPlayer")
        let reference = CKRecord.Reference(recordID: playerID, action: .none)
        let daily = DailyPlayer(playerID: reference, cigars: cigars ?? 0, date: Date())
        record.setValuesForKeys(daily.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
            }
        }
    }
    
    func updateDaily(playerID: CKRecord.ID, cigars: Int) {
        let predicate = NSPredicate(format: "playerID == %@", playerID)
        let query = CKQuery(recordType: "DailyPlayer", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let record = records.first
                var totalCigars = record?.value(forKey: "cigars") as! Int + cigars
                record?.setValue(totalCigars, forKey: "cigars")
                
                self.dvm.create(record: record ?? CKRecord(recordType: "DailyPlayer")) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let record):
                        print(record)
                    }
                }
            }
        }
    }
    
}



enum sheetContent: Identifiable {
    case nicotine
    case tar
    var id: Int {
        hashValue
    }
}

class TestSheetViewModel: ObservableObject {
    @Published var showSheetContentStatus: sheetContent = .nicotine
    @Published var sheetStatus: Bool = false
    @Published var showCalendar: Bool = false
    @Published var progressDataByDate: [ProgressModel] = []
    @Published var progressData: [ProgressModel] = [
        ProgressModel(date: CalendarHelper().getItemDate(day: 1, currAppDate: Date()), cigarettes: 5),
        ProgressModel(date: CalendarHelper().getItemDate(day: 2, currAppDate: Date()), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 3, currAppDate: Date()), cigarettes: 3),
        ProgressModel(date: CalendarHelper().getItemDate(day: 4, currAppDate: Date()), cigarettes: 6),
        ProgressModel(date: CalendarHelper().getItemDate(day: 5, currAppDate: Date()), cigarettes: 1),
        ProgressModel(date: CalendarHelper().getItemDate(day: 29, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 2),
        ProgressModel(date: CalendarHelper().getItemDate(day: 30, currAppDate: Calendar.current.date(byAdding: .month, value: -1, to: Date())!), cigarettes: 3)
    ]
    
    
}

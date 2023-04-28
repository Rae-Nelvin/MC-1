//
//  DailyPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import CloudKit
import SwiftUI

class DailyPlayerViewModel: ObservableObject {
    
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    @Published var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    func createDaily(cigars: Int?) {
        let record = CKRecord(recordType: "DailyPlayer")
        let reference = CKRecord.Reference(recordID: self.player.id ?? CKRecord.ID(recordName: "Placeholder"), action: .none)
        let daily = DailyPlayer(playerID: reference, cigars: cigars ?? 0)
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

struct HomeDailyPlayer: View {
    @ObservedObject var dpvm: DailyPlayerViewModel
    
    init(player: Player) {
        self.dpvm = DailyPlayerViewModel(player: player)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(dpvm.player.name)
                Button("Make Daily Track") {
                    dpvm.createDaily(cigars: 2)
                }
            }
        }
    }
}

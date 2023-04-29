//
//  MissionViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 29/04/23.
//

import Foundation
import CloudKit
import SwiftUI

class MissionViewModel: ObservableObject {
    private var player: Player
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    @Published var missions: [Mission] = []
    private var playerMissions: [PlayerMission] = []
    
    init(player: Player) {
        self.player = player
        fetchingPlayerMissions()
    }
    
    func fetchingPlayerMissions() {
        self.missions = []
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = NSPredicate(format: "playerID == %@ AND creationDate >= %@ AND creationDate < %@", self.player.id ?? CKRecord.ID(recordName: "placeholder"), startDate as NSDate, endDate as NSDate)
        let query = CKQuery(recordType: "PlayerMission", predicate: predicate)
        
        self.dvm.read(query: query) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                for record in records {
                    let playerMission = PlayerMission(id: record.recordID, playerID: record.value(forKey: "playerID") as! CKRecord.Reference, missionTitle: record.value(forKey: "missionTitle") as! String, missionPoint: record.value(forKey: "missionPoint") as! Int)
                    self?.playerMissions.append(playerMission)
                }
            }
            self?.fetchingMissions()
        }
    }
    
    func fetchingMissions() {
        for var mission in missionLists.lists {
            for playerMission in self.playerMissions {
                if Mission.compare(lhs: mission, rhs: playerMission) == true {
                    mission.isDone = true
                }
            }
            self.missions.append(mission)
        }
    }
    
    func finishMission(mission: Mission) {
        let record = CKRecord(recordType: "PlayerMission")
        let reference = CKRecord.Reference(recordID: self.player.id ?? CKRecord.ID(recordName: "Placeholder"), action: .none)
        let playerMission = PlayerMission(playerID: reference, missionTitle: mission.title, missionPoint: mission.point)
        record.setValuesForKeys(playerMission.toDictionary())
        
        self.dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success( _):
                print("Record Uploaded")
                self.fetchingPlayerMissions()
            }
            
        }
    }
    
    func cancelFinishedMission(mission: Mission) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = NSPredicate(format: "playerID == %@ AND creationDate >= %@ AND creationDate < %@", self.player.id ?? CKRecord.ID(recordName: "placeholder"), startDate as NSDate, endDate as NSDate)
        let query = CKQuery(recordType: "PlayerMission", predicate: predicate)
        
        self.dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                for record in records {
                    let playerMission = PlayerMission(id: record.recordID, playerID: record.value(forKey: "playerID") as! CKRecord.Reference, missionTitle: record.value(forKey: "missionTitle") as! String, missionPoint: record.value(forKey: "missionPoint") as! Int)
                    if (mission.title == playerMission.missionTitle && mission.point == playerMission.missionPoint) {
                        self.dvm.delete(recordID: playerMission.id ?? CKRecord.ID(recordName: "Placeholder")) { result in
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let status):
                                print(status)
                                self.fetchingPlayerMissions()
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}

// Dummy View Delete Later

struct MissionViewModelView: View {
    
    @ObservedObject var mvm: MissionViewModel
    
    init(player: Player) {
        self.mvm = MissionViewModel(player: player)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(mvm.missions, id: \.id) { mission in
                    HStack {
                        VStack {
                            Text(mission.title)
                            Text(mission.description)
                        }
                        Button("Check") {
                            mvm.finishMission(mission: mission)
                        }
                        .disabled(mission.isDone == true)
                        Button("Uncheck") {
                            mvm.cancelFinishedMission(mission: mission)
                        }
                        .disabled(mission.isDone == false)
                        Text(String(mission.isDone))
                    }
                }
            }
        }
    }
}

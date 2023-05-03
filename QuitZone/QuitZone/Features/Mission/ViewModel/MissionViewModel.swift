//
//  MissionViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 29/04/23.
//

import Foundation
import SwiftUI
import CoreData

class MissionViewModel: ObservableObject {
    
    private var player: Player
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
        
        let request: NSFetchRequest<PlayerMission> = PlayerMission.fetchRequest()
        request.predicate = NSPredicate(format: "playerID == %@ AND creationDate >= %@ AND creationDate < %@", self.player.objectID, startDate as NSDate, endDate as NSDate)
        
        do {
            let count = try PersistenceController.shared.container.viewContext.count(for: request)
            if count > 0 {
                let results = try PersistenceController.shared.container.viewContext.fetch(request)
                for result in results {
                    let playerMission = result
                    self.playerMissions.append(playerMission)
                }
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
        self.fetchingMissions()
    }
    
    func fetchingMissions() {
        for missionList in missionLists.lists {
            var mission: Mission = missionList
            for playerMission in self.playerMissions {
                if Mission.compare(lhs: missionList, rhs: playerMission) == true {
                    mission = Mission(title: missionList.title, description: missionList.description, point: missionList.point, isDone: true)
                } else {
                    mission = Mission(title: missionList.title, description: missionList.description, point: missionList.point, isDone: false)
                }
            }
            self.missions.append(mission)
        }
    }
    
    func finishMission(mission: Mission) {
        let playerMission = PlayerMission(context: PersistenceController.shared.viewContext)
        
        playerMission.setValue(self.player.id, forKey: "playerID")
        playerMission.setValue(mission.title, forKey: "missionTitle")
        playerMission.setValue(mission.point, forKey: "missionPoint")
        
        PersistenceController.shared.save()
    }
    
    func cancelFinishedMission(mission: Mission) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        let request: NSFetchRequest<PlayerMission> = PlayerMission.fetchRequest()
        request.predicate = NSPredicate(format: "playerID == %@ AND creationDate >= %@ AND creationDate < %@", self.player.objectID, startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            for result in results {
                let playerMission = result
                if (mission.title == playerMission.missionTitle && mission.point == playerMission.missionPoint) {
                    PersistenceController.shared.viewContext.delete(playerMission)
                    PersistenceController.shared.save()
                }
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
}

// Dummy View Delete Later

struct MissionViewModelView: View {
    
    @ObservedObject var mvm: MissionViewModel
    
    init(player: Player) {
        mvm = MissionViewModel(player: player)
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

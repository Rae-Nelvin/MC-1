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
    @Published var playerMissions: [PlayerMission] = []
    
    init(player: Player) {
        self.player = player
        fetchingPlayerMissions()
    }
    
    func fetchingPlayerMissions() {
        self.missions = []
        let date = Date()
        let calendar = Calendar.current
        var startOfWeek: Date = Date()
        var interval = TimeInterval()
        _ = calendar.dateInterval(of: .weekOfYear,start: &startOfWeek, interval: &interval, for: date)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let request: NSFetchRequest<PlayerMission> = PlayerMission.fetchRequest()
        request.predicate = NSPredicate(format: "player == %@ AND createdAt >= %@ AND createdAt < %@", self.player, startOfWeek as NSDate, endOfWeek as NSDate)
        
        do {
            let count = try PersistenceController.shared.container.viewContext.count(for: request)
            if count > 0 {
                let results = try PersistenceController.shared.container.viewContext.fetch(request)
                for result in results {
                    let playerMission = result
                    self.playerMissions.append(playerMission)
                    print("Fetched result: ", result)
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
        
        playerMission.missionTitle = mission.title
        playerMission.missionPoint = Int16(mission.point)
        playerMission.createdAt = Date()
        playerMission.player = self.player
        
        PersistenceController.shared.save()
        self.fetchingPlayerMissions()
    }
    
    func cancelFinishedMission(mission: Mission) {
        let date = Date()
        let calendar = Calendar.current
        var startOfWeek: Date = Date()
        var interval = TimeInterval()
        _ = calendar.dateInterval(of: .weekOfYear,start: &startOfWeek, interval: &interval, for: date)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let request: NSFetchRequest<PlayerMission> = PlayerMission.fetchRequest()
        request.predicate = NSPredicate(format: "player == %@ AND creationDate >= %@ AND creationDate < %@", self.player, startOfWeek as NSDate, endOfWeek as NSDate)
        
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
        self.fetchingPlayerMissions()
    }
    
}

//
//  TeamViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 23/04/23.
//

import Foundation
import CoreData
import SwiftUI

class TeamViewModel: ObservableObject {
    
    @Published var teams: [Team] = []
    
    init() {
    }
    
    private func generateRandomStrings() -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = 5
        var randomString = ""

        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<allowedChars.count)
            let newChar = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomIndex)]
            randomString.append(newChar)
        }

        return randomString
    }
    
    func createMember(player: Player, team: Team) {
        let member = Member(context: PersistenceController.shared.viewContext)
        
        member.setValue(player.id, forKey: "playerID")
        member.setValue(team.id, forKey: "teamID")
        member.setValue(0, forKey: "score")
        member.setValue(Date(), forKey: "date_joined")
        
        PersistenceController.shared.save()
    }
    
    func getMemberOfs(player: Player) {
        let request: NSFetchRequest<Member> = Member.fetchRequest()
        request.predicate = NSPredicate(format: "player == %@", player)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            if results.count > 0 {
                for result in results {
                    self.getTeam(team: result.team!)
                }
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
    func deleteMember(player: Player, team: Team) {
        let request: NSFetchRequest<Member> = Member.fetchRequest()
        request.predicate = NSPredicate(format: "playerID == %@ && teamID == %@", player.objectID, team.objectID)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            guard let result = results.first else { return }
            PersistenceController.shared.viewContext.delete(result)
            
            PersistenceController.shared.save()
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
    func createTeam(name: String, goal: String) {
        let team = Team(context: PersistenceController.shared.viewContext)
        let inviteCode = generateRandomStrings()
        
        team.setValue(name, forKey: "name")
        team.setValue(inviteCode, forKey: "inviteCode")
        team.setValue(goal, forKey: "goal")
        
        PersistenceController.shared.save()
    }
    
    func getTeam(team: Team) {
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "team == %@", team)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            guard let result = results.first else { return }
            self.teams.append(result)
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
    func updateTeam(name: String?, player: Int16?, team: Team) {
        var players: Int16 = 0
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamID == %@", team.objectID)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            guard let result = results.first else { return }
            if name != "" {
                result.setValue(name, forKey: "name")
            }
            
            if player != 0 {
                players = players + (player ?? 0)
                result.setValue(players, forKey: "players")
            }
            
            PersistenceController.shared.save()
            
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
    func joinTeam(inviteCode: String, player: Player) {
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "inviteCode == %@", inviteCode)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            guard let result = results.first else { return }
            self.createMember(player: player, team: result)
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
    func deleteTeam(team: Team) {
        let requestMember: NSFetchRequest<Member> = Member.fetchRequest()
        requestMember.predicate = NSPredicate(format: "team == %@", team)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(requestMember)
            for result in results {
                self.deleteMember(player: result.player!, team: result.team!)
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
        
        let requestTeam: NSFetchRequest<Team> = Team.fetchRequest()
        requestTeam.predicate = NSPredicate(format: "team == %@", team)
        do {
            let results = try PersistenceController.shared.viewContext.fetch(requestTeam)
            guard let result = results.first else { return }
            PersistenceController.shared.viewContext.delete(result)
            
            PersistenceController.shared.save()
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
    }
    
}

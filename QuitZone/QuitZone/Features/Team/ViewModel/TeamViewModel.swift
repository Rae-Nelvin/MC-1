//
//  TeamViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 23/04/23.
//

import Foundation
import CloudKit
import SwiftUI

class TeamViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    @Published var teams: [Team] = []
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
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
    
    func createMember(playerID: CKRecord.ID, teamID: CKRecord.ID) {
        let record = CKRecord(recordType: "Member")
        let playerReference = CKRecord.Reference(recordID: playerID, action: .none)
        let teamReference = CKRecord.Reference(recordID: teamID, action: .none)
        
        let member = Member(playerID: playerReference, teamID: teamReference, score: 0, date_joined: Date())
        record.setValuesForKeys(member.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
                self.updateTeam(name: "", player: 1, teamID: teamID)
            }
        }
    }
    
    func getMemberOfs(playerID: CKRecord.ID) {
        let predicate = NSPredicate(format: "playerID == %@", playerID)
        let query = CKQuery(recordType: "Member", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                for record in records {
                    self.getTeam(teamID: record.value(forKey: "teamID") as! CKRecord.ID)
                }
            }
        }
    }
    
    func deleteMember(playerID: CKRecord.ID, teamID: CKRecord.ID) {
        let predicate = NSPredicate(format: "playerID == %@ && teamID == %@", playerID, teamID)
        let query = CKQuery(recordType: "Member", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let record = records.first
                self.dvm.delete(recordID: record?.recordID ?? CKRecord.ID(recordName: "Placeholder")) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let result):
                        print(result)
                    }
                }
            }
        }
    }
    
    func createTeam(name: String) {
        let record = CKRecord(recordType: "Team")
        let team = Team(name: name, players: 1, inviteCode: generateRandomStrings())
        record.setValuesForKeys(team.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
            }
        }
    }
    
    func getTeam(teamID: CKRecord.ID) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let team = Team(name: (records.first?.value(forKey: "name")) as! String, players: records.first?.value(forKey: "players") as! Int)
                self.teams.append(team)
            }
        }
    }
    
    func updateTeam(name: String?, player: Int?, teamID: CKRecord.ID) {
        let predicate = NSPredicate(format: "teamID == %@", teamID)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let record = records.first
                if name != "" {
                    record?.setValue(name, forKey: "name")
                }
                
                if player != 0 {
                    var players = record?.value(forKey: "players")
                    players = players as! Int + (player ?? 0)
                    record?.setValue(players, forKey: "players")
                }
                
                DispatchQueue.main.async {
                    self.dvm.create(record: record ?? CKRecord(recordType: "Team")) { result in
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
    
    func joinTeam(inviteCode: String, playerID: CKRecord.ID) {
        let predicate = NSPredicate(format: "inviteCode == %@", inviteCode)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let record = records.first
                self.createMember(playerID: playerID, teamID: record?.recordID ?? CKRecord.ID(recordName: "Placeholder"))
            }
        }
    }
    
    func deleteTeam(teamID: CKRecord.ID) {
        var predicate = NSPredicate(format: "teamID == %@", teamID)
        var query = CKQuery(recordType: "Member", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                for result in results {
                    self.deleteMember(playerID: result.value(forKey: "playerID") as! CKRecord.ID, teamID: result.value(forKey: "teamID") as! CKRecord.ID)
                }
            }
        }
        
        predicate = NSPredicate(format: "teamID == %@", teamID)
        query = CKQuery(recordType: "Team", predicate: predicate)
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                let record = records.first
                self.dvm.delete(recordID: record?.recordID ?? CKRecord.ID(recordName: "Placeholder")) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let result):
                        print(result)
                    }
                }
            }
        }
    }
    
}

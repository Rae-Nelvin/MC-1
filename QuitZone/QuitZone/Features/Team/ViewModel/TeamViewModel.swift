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
    
    private func uploadToDatabase(record: CKRecord) {
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let _ = newRecord {
                    print("New Record saved successfully")
                }
            }
        }
    }
    
    func createMember(playerID: CKRecord.ID, teamID: CKRecord.ID) {
        let record = CKRecord(recordType: "Member")
        let playerReference = CKRecord.Reference(recordID: playerID, action: .none)
        let teamReference = CKRecord.Reference(recordID: teamID, action: .none)
        
        let member = Member(playerID: playerReference, teamID: teamReference, score: 0, date_joined: Date())
        record.setValuesForKeys(member.toDictionary())
        
        uploadToDatabase(record: record)
        updateTeam(name: "", player: 1, teamID: teamID)
    }
    
    func getMemberOfs(playerID: CKRecord.ID) {
        let predicate = NSPredicate(format: "playerID == %@", playerID)
        let query = CKQuery(recordType: "Member", predicate: predicate)
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching records \(error.localizedDescription)")
                return
            }
            guard let records = records else {
                print("No records found")
                return
            }
            
            for record in records {
                self.getTeam(teamID: record.value(forKey: "teamID") as! CKRecord.ID)
            }
        }
    }
    
    func deleteMember() {
    }
    
    func createTeam(name: String) {
        let record = CKRecord(recordType: "Team")
        let team = Team(name: name, players: 1, inviteCode: generateRandomStrings())
        record.setValuesForKeys(team.toDictionary())
        
        uploadToDatabase(record: record)
    }
    
    func getTeam(teamID: CKRecord.ID) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching records \(error.localizedDescription)")
                return
            }
            guard let records = records else {
                print("No records found")
                return
            }
            
            let team = Team(name: (records.first?.value(forKey: "name")) as! String, players: records.first?.value(forKey: "players") as! Int)
            self.teams.append(team)
        }
    }
    
    func updateTeam(name: String?, player: Int?, teamID: CKRecord.ID) {
        let predicate = NSPredicate(format: "teamID == %@", teamID)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching records \(error.localizedDescription)")
                return
            }
            guard let records = records else {
                print("No records found")
                return
            }
            
            if name != "" {
                records.first?.setValue(name, forKey: "name")
            }
            
            if player != 0 {
                var players = records.first?.value(forKey: "players")
                players = players as! Int + (player ?? 0)
                records.first?.value(forKey: "players")
            }
            
            self.uploadToDatabase(record: records.first!)
        }
    }
    
    func joinTeam(inviteCode: String, playerID: CKRecord.ID) {
        let predicate = NSPredicate(format: "inviteCode == %@", inviteCode)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching records \(error.localizedDescription)")
                return
            }
            guard let records = records else {
                print("No Records found")
                return
            }
            
            self.createMember(playerID: playerID, teamID: records.first!.recordID)
        }
    }
    
    func deleteTeam() {
    }
    
}

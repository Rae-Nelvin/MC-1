//
//  TeamChallengeViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import CloudKit

class TeamChallengeViewModel: ObservableObject {
    
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    @Published var challenges: [Challenge] = []
    
    func createChallenge(name: String, description: String, typeID: Int, endedAt: Date, teamID: CKRecord.ID) {
        let record = CKRecord(recordType: "Challenge")
        let challenge = Challenge(name: name, description: description, typeID: typeID)
        record.setValuesForKeys(challenge.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
                self.createTeamChallenge(teamID: teamID, challengeID: record.recordID, endedAt: endedAt)
            }
        }
    }
    
    func createTeamChallenge(teamID: CKRecord.ID, challengeID: CKRecord.ID, endedAt: Date) {
        let record = CKRecord(recordType: "TeamChallenge")
        let teamIDReference = CKRecord.Reference(recordID: teamID, action: .none)
        let challengeIDReference = CKRecord.Reference(recordID: challengeID, action: .none)
        let teamChallenge = TeamChallenge(teamID: teamIDReference, challengeID: challengeIDReference, endedAt: endedAt)
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
            }
        }
    }
    
    func readTeamChallenge(team: Team) {
        guard let teamID = team.id else { return }
        let predicate = NSPredicate(format: "teamID == %@", teamID)
        let query = CKQuery(recordType: "TeamChallenge", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                for record in records {
                    self.readChallenge(challengeID: record.value(forKey: "challengeID") as! CKRecord.ID)
                }
            }
        }
    }
    
    func readChallenge(challengeID: CKRecord.ID) {
        let predicate = NSPredicate(format: "challengeID == %@", challengeID)
        let query = CKQuery(recordType: "Challenge", predicate: predicate)
        
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                guard let record = records.first else { return }
                let challenge = Challenge(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, typeID: record.value(forKey: "typeID") as! Int)
                self.challenges.append(challenge)
            }
        }
    }
    
    func updateChallenge(challenge: Challenge, name: String?, description: String?, typeID: Int?) {
        
    }
    
    func deleteChallenge(challengeID: CKRecord.ID) {
        dvm.delete(recordID: challengeID) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }
    
    func deleteTeamChallenge(challenge: Challenge) {
        guard let challengeID = challenge.id else { return }
        let predicate = NSPredicate(format: "challengeID == %@", challengeID)
        let query = CKQuery(recordType: "TeamChallenge", predicate: predicate)
        
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
                        DispatchQueue.main.async {
                            self.deleteChallenge(challengeID: record?.recordID ?? CKRecord.ID(recordName: "Placeholder"))
                        }
                        print(result)
                    }
                }
            }
        }
    }
    
}

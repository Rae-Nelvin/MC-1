//
//  CloudKitPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit
import SwiftUI

enum RecordType: String {
    case player = "Player"
}

class PlayerViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    private var iCloud: CKRecord.ID = CKRecord.ID(recordName: "placeholder")
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        fetchiCloudUserRecord()
    }
    
    private func fetchiCloudUserRecord(){
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.iCloud = id
            }
        }
    }
    
    func savePlayer(name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigarattes: String) {
        let record = CKRecord(recordType: RecordType.player.rawValue)
        let iCloudReference = CKRecord.Reference(recordID: iCloud, action: .none)
        let player = Player(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes, iCloud: iCloudReference)
        record.setValuesForKeys(player.toDictionary())
        
        // Saving record into the Database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let _ = newRecord {
                    print("New Player saved successfully")
                }
            }
        }
    }
    
    func getPlayer(completion: @escaping (Result<CKRecord, Error>) -> Void) {
        let predicate = NSPredicate(format: "iCloud == %@", iCloud)
        let query = CKQuery(recordType: "Player", predicate: predicate)
        
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name", "dob", "frequency", "smokerFor"]
        queryOperation.resultsLimit = 1
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let record = records?.first {
                    completion(.success(record))
                } else {
                    let error = NSError(domain: "iCloud.Testing.QuitZone", code: 404, userInfo: [NSLocalizedDescriptionKey: "User Not Found"])
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updatePlayer(name: String?, dob: Date?, frequency: Int?, smokerFor: Int?, typeOfCigarattes: String?, completion: @escaping (Result<CKRecord, Error>) -> Void ) {
        var player: CKRecord = CKRecord(recordType: "Player")
        getPlayer() { results in
            switch results {
            case .failure(let error):
                print(error)
                return
            case .success(let result):
                player = result
                
                if name != "" {
                    player.setValue(name, forKey: "name")
                }
                
                // Supposedly to be unset after registering so it won't be buggy
                if dob != Date() {
                    player.setValue(dob, forKey: "dob")
                }
                
                if frequency != 0 {
                    player.setValue(frequency, forKey: "frequency")
                }
                
                if smokerFor != 0 {
                    player.setValue(smokerFor, forKey: "smokerFor")
                }
                
                if typeOfCigarattes != "" {
                    player.setValue(typeOfCigarattes, forKey: "typeOfCigarattes")
                }
                
                self.database.save(player) { (savedRecord, error) in
                    if let savedRecord = savedRecord {
                        completion(.success(savedRecord))
                    } else if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                    }
                }
            }
        }
    }
    
    func createPlayerLung() {}
    
    func updatePlayerLung() {}
}

// For Testing Purposes Delete Later

struct PlayerView: View {
    @StateObject private var pvm: PlayerViewModel
    @State private var name: String = ""
    @State private var dob: Date = Date()
    @State private var frequency: Int = 0
    @State private var smokerFor: Int = 0
    @State private var typeOfCigarattes: String = ""
    
    init(pvm: PlayerViewModel) {
        _pvm = StateObject(wrappedValue: pvm)
    }
    
    var body: some View {
        VStack {
            Section(header: Text("Personal Info")) {
                TextField("Enter your name", text: $name)
                DatePicker("Enter your Date of Birth", selection: $dob, displayedComponents: [.date])
            }
            
            Section(header: Text("Smoking Info")) {
                TextField("Enter your frequency of smoking", value: $frequency, formatter: NumberFormatter())
                TextField("Enter you've been smoking for in months", value: $smokerFor, formatter: NumberFormatter())
                TextField("Enter your type of cigarattes", text: $typeOfCigarattes)
            }
        }
        .padding()
        Button("Submit") {
            //            pvm.savePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
            pvm.updatePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    print(success)
                }
            }
        }
        Button("Check Account") {
            pvm.getPlayer { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let success):
                    print(success.recordID)
                }
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(pvm: PlayerViewModel(container: CKContainer.default()))
    }
}

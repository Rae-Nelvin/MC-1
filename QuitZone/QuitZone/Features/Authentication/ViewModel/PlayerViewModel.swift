//
//  CloudKitPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit
import SwiftUI

class PlayerViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    private var iCloud: CKRecord.ID = CKRecord.ID(recordName: "placeholder")
    @Published var player: Player = Player(name: "", dob: Date(), frequency: 0, smokerFor: 0, typeOfCigarattes: "", iCloud: CKRecord.Reference(recordID: CKRecord.ID(recordName: "placeholder"), action: .none))
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        fetchiCloudUserRecord()
    }
    
    func createPlayer(name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigarattes: String) {
        let record = CKRecord(recordType: "Player")
        let iCloudReference = CKRecord.Reference(recordID: iCloud, action: .none)
        let player = Player(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes, iCloud: iCloudReference)
        record.setValuesForKeys(player.toDictionary())
        
        self.uploadToDatabase(record: record)
    }
    
    private func uploadToDatabase(record: CKRecord) {
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
    
    private func fetchiCloudUserRecord() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.iCloud = id
            }
        }
    }
    
    func getPlayer(completion: @escaping (Result<CKRecord, Error>) -> Void) {
        let predicate = NSPredicate(format: "iCloud == %@", iCloud)
        let query = CKQuery(recordType: "Player", predicate: predicate)
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let record = records?.first {
                    completion(.success(record))
                    let fetchedPlayer = Player(id: record.recordID,name: record.value(forKey: "name") as! String, dob: record.value(forKey: "dob") as! Date, frequency: record.value(forKey: "frequency") as! Int, smokerFor: record.value(forKey: "smokerFor") as! Int, typeOfCigarattes: record.value(forKey: "typeOfCigarattes") as! String, iCloud: record.value(forKey: "iCloud") as! CKRecord.Reference)
                    self.player = fetchedPlayer
                } else {
                    let error = NSError(domain: "iCloud.Testing.QuitZone", code: 404, userInfo: [NSLocalizedDescriptionKey: "User Not Found"])
                    completion(.failure(error))
                }
            }
        }
    }
    
    func updatePlayer(name: String?, dob: Date?, frequency: Int?, smokerFor: Int?, typeOfCigarattes: String?) {
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
                
                self.uploadToDatabase(record: player)
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
            //            pvm.createPlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
            pvm.updatePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
        }
        Button("Check Account") {
            pvm.getPlayer(){ result in
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

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(pvm: PlayerViewModel(container: CKContainer.default()))
    }
}

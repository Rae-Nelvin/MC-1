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
    
    private var iCloud: CKRecord.ID = CKRecord.ID(recordName: "placeholder")
    @Published var player: Player = Player(name: "", dob: Date(), frequency: 0, smokerFor: 0, typeOfCigarattes: "", iCloud: CKRecord.Reference(recordID: CKRecord.ID(recordName: "placeholder"), action: .none))
    private var dvm: DatabaseViewModel = DatabaseViewModel.myInstance
    @Published var isRegistered: Bool = false
    
    init() {
        fetchiCloudUserRecord()
//        getPlayer()
    }
    
    func createPlayer(name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigarattes: String) {
        let record = CKRecord(recordType: "Player")
        let iCloudReference = CKRecord.Reference(recordID: iCloud, action: .none)
        let player = Player(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes, iCloud: iCloudReference)
        record.setValuesForKeys(player.toDictionary())
        
        dvm.create(record: record) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let record):
                print(record)
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
    
    func getPlayer() {
        let predicate = NSPredicate(format: "iCloud == %@", iCloud)
        let query = CKQuery(recordType: "Player", predicate: predicate)
        
        dvm.read(query: query) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.isRegistered = false
            case .success(let records):
                let record = records.first
                let fetchedPlayer = Player(id: record?.recordID,name: record?.value(forKey: "name") as! String, dob: record?.value(forKey: "dob") as! Date, frequency: record?.value(forKey: "frequency") as! Int, smokerFor: record?.value(forKey: "smokerFor") as! Int, typeOfCigarattes: record?.value(forKey: "typeOfCigarattes") as! String, iCloud: record?.value(forKey: "iCloud") as! CKRecord.Reference)
                self?.player = fetchedPlayer
                self?.isRegistered = true
                print(record)
            }
        }
    }
    
    func updatePlayer(name: String?, dob: Date?, frequency: Int?, smokerFor: Int?, typeOfCigarattes: String?) {
        let predicate = NSPredicate(format: "iCloud == %@", iCloud)
        let query = CKQuery(recordType: "Player", predicate: predicate)
        dvm.read(query: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let records):
                DispatchQueue.main.async {
                    let player = records.first
                    
                    if name != "" {
                        player?.setValue(name, forKey: "name")
                    }
                    
                    // Supposedly to be unset after registering so it won't be buggy
                    if dob != Date() {
                        player?.setValue(dob, forKey: "dob")
                    }
                    
                    if frequency != 0 {
                        player?.setValue(frequency, forKey: "frequency")
                    }
                    
                    if smokerFor != 0 {
                        player?.setValue(smokerFor, forKey: "smokerFor")
                    }
                    
                    if typeOfCigarattes != "" {
                        player?.setValue(typeOfCigarattes, forKey: "typeOfCigarattes")
                    }
                    
                    self.dvm.create(record: player ?? CKRecord(recordType: "")) { result in
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
        NavigationView {
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
                Button("Submit") {
                    //            pvm.createPlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
                    pvm.updatePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
                }
                Button("Check Account") {
                    pvm.getPlayer()
                }
                NavigationLink(destination: MissionViewModelView(mvm: MissionViewModel(player: pvm.player))) {
                    Text("Go to Mission Page")
                }
            }
            .padding()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(pvm: PlayerViewModel())
    }
}

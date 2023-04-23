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
    
    func saveUser(name: String, dob: Date, frequency: Int, smokerFor: Int, typeOfCigarattes: String) {
        let record = CKRecord(recordType: RecordType.player.rawValue)
        let iCloudReference = CKRecord.Reference(recordID: iCloud, action: .none)
        let player = User(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes, iCloud: iCloudReference)
        record.setValuesForKeys(player.toDictionary())
        
        // Saving record into the Database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if let _ = newRecord {
                    print("SAVED")
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
            pvm.saveUser(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(pvm: PlayerViewModel(container: CKContainer.default()))
    }
}

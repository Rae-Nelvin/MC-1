//
//  CloudKitPlayerViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import SwiftUI
import CoreData

class PlayerViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    private var icvm: iCloudViewModel
    @Published var isRegistered: Bool = false
    @Published var isLoading: Bool = true
    @Published var player: Player = Player()
    
    init() {
        self.icvm = iCloudViewModel()
        DispatchQueue.main.async {
            if self.icvm.isLoading == false {
                self.getPlayer()
            }
        }
    }
    
    func createPlayer(name: String, dob: Date, frequency: Int16, smokerFor: Int16, typeOfCigarattes: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: viewContext)
        let player = NSManagedObject(entity: entity!, insertInto: viewContext)
        
        player.setValue(name, forKey: "name")
        player.setValue(dob, forKey: "dob")
        player.setValue(frequency, forKey: "frequency")
        player.setValue(smokerFor, forKey: "smokerFor")
        player.setValue(typeOfCigarattes, forKey: "typeOfCigarattes")
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getPlayer() {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.predicate = NSPredicate(format: "iCloud == %@", icvm.iCloud)
        
        do {
            let results = try viewContext.fetch(request)
            player = results.first ?? Player()
        } catch let error {
            print("Error fetching records: \(error)")
        }
    }
    
    func updatePlayer(name: String?, dob: Date?, frequency: Int16?, smokerFor: Int16?, typeOfCigarattes: String?, player: Player) {
        
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
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

// For Testing Purposes Delete Later

struct PlayerView: View {
    @ObservedObject private var pvm: PlayerViewModel = PlayerViewModel()
    @State private var name: String = ""
    @State private var dob: Date = Date()
    @State private var frequency: Int16 = 0
    @State private var smokerFor: Int16 = 0
    @State private var typeOfCigarattes: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if pvm.isLoading == false && pvm.isRegistered == false {
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
                            pvm.updatePlayer(name: name, dob: dob, frequency: frequency, smokerFor: smokerFor, typeOfCigarattes: typeOfCigarattes, player: pvm.player)
                        }
                        Button("Check Account") {
                            pvm.getPlayer()
                        }
                    }
                } else if pvm.isRegistered == true {
                    MissionViewModelView(player: pvm.player)
                }
                else {
                    Text("Loading")
                }
            }
        }
        .padding()
    }
}

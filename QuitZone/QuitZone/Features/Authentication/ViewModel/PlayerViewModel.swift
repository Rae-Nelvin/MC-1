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
    
    private var icvm: iCloudViewModel
    @Published var isRegistered: Bool = false
    @Published var isLoading: Bool = true
    @Published var player: Player = Player()
    @Published var currPage: String = "Splash Screen"
    
    init() {
        self.icvm = iCloudViewModel()
        self.isLoading = false
        DispatchQueue.main.async {
            if self.icvm.isLoading == false {
                self.getPlayer()
            }
        }
    }
    
    func createPlayer(name: String, dob: Date, frequency: Int16, smokerFor: Int16, typeOfCigarattes: Cigarattes) {
        let player = Player(context: PersistenceController.shared.viewContext)
        
        player.name = name
        player.dob = dob
        player.frequency = frequency
        player.smokerFor = smokerFor
        player.typeOfCigarattes = typeOfCigarattes.name
        player.iCloud = icvm.iCloud
        
        PersistenceController.shared.save()
        self.currPage = "Home Screen"
    }
    
    func getPlayer() {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.predicate = NSPredicate(format: "iCloud == %@", icvm.iCloud)
        
        do {
            let count = try PersistenceController.shared.viewContext.count(for: request)
            print("Player", count)
            if count > 0 {
                let results = try PersistenceController.shared.viewContext.fetch(request)
                player = results.first ?? Player()
                isRegistered = true
            }
        } catch let error {
            print("Error fetching records: \(error)")
        }
    }
    
    func updatePlayer(name: String?, dob: Date?, frequency: Int16?, smokerFor: Int16?, typeOfCigarattes: Cigarattes?, player: Player) {
        
        if name != "" {
            player.name = name
        }
        
        // Supposedly to be unset after registering so it won't be buggy
        if dob != Date() {
            player.dob = dob
        }
        
        if frequency != 0 {
            player.frequency = frequency!
        }
        
        if smokerFor != 0 {
            player.smokerFor = smokerFor!
        }
        
        if (typeOfCigarattes != nil) {
            player.typeOfCigarattes = typeOfCigarattes?.name
        }
        
        PersistenceController.shared.save()
    }
}

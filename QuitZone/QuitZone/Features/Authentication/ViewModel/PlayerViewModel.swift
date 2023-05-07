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
        let lvm: LungViewModel = LungViewModel(player: player)
        let lungCondition = lvm.calculateRegisterLungCondition()
        player.lungCondition = lungCondition
        
        self.player = player
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
    
    func updatePlayer(name: String?, frequency: Int16?, smokerFor: Int16?, typeOfCigarattes: Cigarattes?, email: String?, phone: String?, avatar: UIImage? , lungCondition: String?, player: Player) {
        
        if name != "" {
            player.name = name
        }
        
        if frequency != 0 {
            player.frequency = frequency!
        }
        
        if smokerFor != 0 {
            player.smokerFor = smokerFor!
        }
        
        if typeOfCigarattes != nil {
            player.typeOfCigarattes = typeOfCigarattes?.name
        }
        
        if email != "" {
            player.email = email
        }
        
        if phone != "" {
            player.phone = phone
        }
        
        if avatar != nil {
            player.avatar = self.convertImageToBinaryData(avatar!)
        }
        
        if lungCondition != "" {
            player.lungCondition = lungCondition
        }
        
        PersistenceController.shared.save()
        self.getPlayer()
    }
    
    private func convertImageToBinaryData(_ image: UIImage) -> Data? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: self.player.dob!)
    }
}

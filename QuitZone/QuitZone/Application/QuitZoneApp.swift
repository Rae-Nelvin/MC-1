//
//  QuitZoneApp.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI
import CloudKit
import CoreData

@main
struct QuitZoneApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject var qzvm: QuitZoneViewModel = QuitZoneViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch qzvm.currentPage {
                case "iCloudView":
                    PlayerView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                default:
                    PlayerView()
                }
            }
        }
    }
    
   
}

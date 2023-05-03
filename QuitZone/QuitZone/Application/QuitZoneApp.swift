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
    @ObservedObject var qzvm: QuitZoneViewModel = QuitZoneViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch qzvm.currentPage {
                case "iCloudView":
                    PlayerView()
                default:
                    PlayerView()
                }
            }
        }
    }
    
   
}

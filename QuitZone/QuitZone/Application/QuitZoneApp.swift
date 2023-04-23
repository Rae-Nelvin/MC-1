//
//  QuitZoneApp.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI
import CloudKit

@main
struct QuitZoneApp: App {
    
    // Public Container
//    let container = CKContainer(identifier: "iCloud.Testing.QuitZone")
    
    var body: some Scene {
        WindowGroup {
//            CloudKitUser(container: container)
            ContentView()
        }
    }
}

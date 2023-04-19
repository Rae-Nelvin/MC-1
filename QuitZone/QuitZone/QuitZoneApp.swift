//
//  QuitZoneApp.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

@main
struct QuitZoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

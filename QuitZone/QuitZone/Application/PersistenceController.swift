//
//  Persistence.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 02/05/23.
//

import Foundation
import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "QuitZoneModel")

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }

        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.QuitZoneWithCoreData")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}


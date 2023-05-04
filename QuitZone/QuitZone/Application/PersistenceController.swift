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
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentCloudKitContainer(name: "QuitZoneModel")
            
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }
        
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.QuitZoneWithCoreData")
        description.cloudKitContainerOptions?.databaseScope = .public
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Error saving to CD : \(error)")
        }
    }
    
    func deleteAllPlayers() {
        let managedObjectContext = viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Player")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch let error {
            print("Error deleting records: \(error)")
        }
    }
}


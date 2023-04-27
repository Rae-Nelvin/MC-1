//
//  DatabaseViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import CloudKit

class DatabaseViewModel {
    static let myInstance = DatabaseViewModel()
    private var database: CKDatabase
    private var container: CKContainer = CKContainer(identifier: "iCloud.Testing.QuitZone")
    
    private init() {
        self.database = self.container.publicCloudDatabase
    }
    
    func create(record: CKRecord, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        self.database.save(record) { newRecord, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let newRecord = newRecord {
                        completion(.success(newRecord))
                    }
                }
            }
        }
    }
    
    func read(query: CKQuery, completion: @escaping (Result<[CKRecord], Error>) -> Void) {
        var fetchedRecords: [CKRecord] = []
        self.database.perform(query, inZoneWith: nil) { [weak self] (records, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let records = records else {
                    let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Records Not Found"])
                    completion(.failure(error))
                    return
                }
                
                fetchedRecords.append(contentsOf: records)
                completion(.success(fetchedRecords))
            }
        }
    }
    
    func delete(recordID: CKRecord.ID, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.database.delete(withRecordID: recordID) { (records, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}

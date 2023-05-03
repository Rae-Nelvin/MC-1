//
//  DatabaseViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 25/04/23.
//

import Foundation
import CloudKit

class CloudKitDatabaseViewModel {
    static let myInstance = CloudKitDatabaseViewModel()
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
                }
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    self.database.fetch(withRecordID: record.recordID) { (record, error) in
                        if let record = record {
                            timer.invalidate()
                            completion(.success(record))
                        }
                    }
                }
            }
        }
    }
    
    func read(query: CKQuery, completion: @escaping (Result<[CKRecord], Error>) -> Void) {
        var fetchedRecords: [CKRecord] = []
        self.database.perform(query, inZoneWith: nil) { (records, error) in
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
        self.database.delete(withRecordID: recordID) { (recordID, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    let fetchOperation = CKFetchRecordsOperation(recordIDs: [recordID!])
                    fetchOperation.fetchRecordsCompletionBlock = { (records, error) in
                        if error != nil {
                            completion(.success(true))
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self?.delete(recordID: recordID!, completion: completion)
                            }
                        }
                    }
                    self?.database.add(fetchOperation)
                }
            }
        }
    }
}

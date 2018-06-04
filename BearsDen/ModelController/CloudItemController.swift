//
//  CloudItemController.swift
//  BearsDen
//
//  Created by James Neeley on 5/10/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CloudKit

class CloudItemController {
    
    //MARK: - Properties
    
    static let shared = CloudItemController()
    let cloudKitManager = CloudKitManager()
    
    
    var cloudItem: CloudItem?
    
    //MARK: - CRUD
    
    func createCloudItem(withName name: String, barcode: String, completion: @escaping(Bool) -> Void) {
        let newCloudItem = CloudItem(name: name, barcode: barcode)
        cloudItem = newCloudItem
        let record = [CKRecord(cloudItem: newCloudItem)]
        cloudKitManager.modifyRecords(records: record, perRecordCompletion: nil) { (_, error) in
            if let error = error {
                completion(false)
                print("error saving clouditem to the cloud \(error)")
                return
            }
            completion(true)
        }
    }
    
    func update(cloudItem: CloudItem, name: String, completion: @escaping(Bool) ->Void) {
        cloudItem.name = name
        let record = [CKRecord(cloudItem: cloudItem)]
        cloudKitManager.modifyRecords(records: record, perRecordCompletion: nil) { (_, error) in
            if let error = error {
                print("error updating clouditem \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }

    //MARK: - Fetch and Save
    
    func fetchCloudItem(WithBarcode barcode: String, completion: @escaping(CloudItem?) -> Void) {
        cloudKitManager.fetchRecords(WithBarcode: barcode) { (records, error) in
            if let error = error {
                print("error fetching records \(error)")
                completion(nil)
                return
            }
            guard let records = records else {completion(nil) ; return}
            if records.count > 0  {
                let cloudItems = records.compactMap({ CloudItem(cloudKitRecord: $0 )})
                let cloudItem = cloudItems[0]
                print("success fething records")
                completion(cloudItem)
            } else {
                completion(nil)
                return
            }
        }
    }
}


//
//  CloudKitManager.swift
//  BearsDen
//
//  Created by James Neeley on 5/10/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import  CloudKit

class CloudKitManager {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func modifyRecords(records: [CKRecord],
                       perRecordCompletion: ((CKRecord?, Error?) -> Void)?,
                       completion: (([CKRecord]?, Error?) -> Void)?) {
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.perRecordCompletionBlock = perRecordCompletion
        operation.modifyRecordsCompletionBlock = { (records, _, error) in
            completion?(records, error)
        }
        publicDB.add(operation)
    }
    
    
    //need to add predicate search tearm in the parameters
    func fetchRecords(WithBarcode barcode: String, completion: @escaping([CKRecord]?, Error?) -> Void) {
        let predicate = NSPredicate(format:"barcode == %@", barcode)
        let query = CKQuery(recordType: CloudItem.itemTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}

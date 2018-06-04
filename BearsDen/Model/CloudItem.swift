//
//  CloudItem.swift
//  BearsDen
//
//  Created by James Neeley on 5/10/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CloudKit

class CloudItem {
    
    static let itemTypeKey = "CloudItem"
    static let nameTextKey = "name"
    static let barcodeTextKey = "barcode"
    static let ckRecordIDKey = "recordID"
    
    var name: String
    let barcode: String
    var ckRecordID: CKRecordID?
    
    init(name: String, barcode: String) {
        self.name = name
        self.barcode = barcode
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[CloudItem.nameTextKey] as? String,
            let barcode = cloudKitRecord[CloudItem.barcodeTextKey] as? String,
            let ckRecordID = cloudKitRecord[CloudItem.ckRecordIDKey] as? CKRecordID else {return nil}
        
        self.name = name
        self.barcode = barcode
        self.ckRecordID = ckRecordID
    }
}

extension CloudItem: Equatable {}

func ==(lhs: CloudItem, rhs: CloudItem) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.barcode != rhs.barcode {return false}
    if lhs.ckRecordID != rhs.ckRecordID {return false}
    return true
}

extension CKRecord {
    convenience init(cloudItem: CloudItem) {
        let recordID = cloudItem.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: CloudItem.itemTypeKey, recordID: recordID)
        self.setValue(cloudItem.name, forKey: CloudItem.nameTextKey)
        self.setValue(cloudItem.barcode, forKey: CloudItem.barcodeTextKey)
        cloudItem.ckRecordID = recordID
    }
}

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
    static let weightTextKey = "weight"
    static let catagoryTextKey = "catagory"
    static let unitTextKey = "unit"
    static let barcodeTextKey = "barcode"
    static let ckRecordIDKey = "recordID"
    
    var name: String
    var weight: String
    var catagory: String
    var unit: String
    let barcode: String
    var ckRecordID: CKRecordID?
    
    init(name: String, weight: String, catagory: String, unit: String, barcode: String) {
        self.name = name
        self.weight = weight
        self.catagory = catagory
        self.unit = unit
        self.barcode = barcode
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[CloudItem.nameTextKey] as? String,
            let weight = cloudKitRecord[CloudItem.weightTextKey] as? String,
            let catagory = cloudKitRecord[CloudItem.catagoryTextKey] as? String,
            let unit = cloudKitRecord[CloudItem.unitTextKey] as? String,
            let barcode = cloudKitRecord[CloudItem.barcodeTextKey] as? String,
            let ckRecordID = cloudKitRecord[CloudItem.ckRecordIDKey] as? CKRecordID else {return nil}
        
        self.name = name
        self.weight = weight
        self.catagory = catagory
        self.unit = unit
        self.barcode = barcode
        self.ckRecordID = ckRecordID
    }
}

extension CloudItem: Equatable {}

func ==(lhs: CloudItem, rhs: CloudItem) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.weight != rhs.weight {return false}
    if lhs.catagory != rhs.catagory {return false}
    if lhs.unit != rhs.unit {return false}
    if lhs.barcode != rhs.barcode {return false}
    if lhs.ckRecordID != rhs.ckRecordID {return false}
    return true
}

extension CKRecord {
    convenience init(cloudItem: CloudItem) {
        let recordID = cloudItem.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: CloudItem.itemTypeKey, recordID: recordID)
        self.setValue(cloudItem.name, forKey: CloudItem.nameTextKey)
        self.setValue(cloudItem.weight, forKey: CloudItem.weightTextKey)
        self.setValue(cloudItem.catagory, forKey: CloudItem.catagoryTextKey)
        self.setValue(cloudItem.unit, forKey: CloudItem.unitTextKey)
        self.setValue(cloudItem.barcode, forKey: CloudItem.barcodeTextKey)
        cloudItem.ckRecordID = recordID
    }
}

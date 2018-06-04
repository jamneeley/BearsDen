//
//  Item.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

extension Item {

    convenience init(name: String, quantity: Double, expirationDate: Date, stocked: Date, barcode: String, shelf: Shelf, Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.name = name
        self.quantity = quantity
        self.stocked = stocked
        self.shelf = shelf
        self.barcode = barcode
        self.expirationDate = expirationDate
    }
}


//
//  Item.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    convenience init(name: String, quantity: Double, stocked: Date, expirationDate: Date, shelf: Shelf,  Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.name = name
        self.quantity = quantity
        self.stocked = stocked
        self.expirationDate = expirationDate
        self.shelf = shelf
    }
}

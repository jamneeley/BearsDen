//
//  ItemController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation

class ItemController {
    
    static let shared = ItemController()
    
    func createItemWithAll(name: String, quantity: Double, stocked: Date, expirationDate: Date, barcode: Int64, shelf: Shelf) {
        let _ = Item(name: name, quantity: quantity, expirationDate: expirationDate, stocked: stocked, barcode: barcode, shelf: shelf)
        UserController.shared.saveToCoreData()
    }
    
    func update(Item item: Item, name: String, quantity: Double, expirationDate: Date, shelf: Shelf) {
        item.name = name
        item.quantity = quantity
        item.expirationDate = expirationDate
        item.shelf = shelf
        UserController.shared.saveToCoreData()
    }
    
    func delete(Item item: Item) {
        item.managedObjectContext?.delete(item)
        UserController.shared.saveToCoreData()
    }
}

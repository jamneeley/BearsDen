//
//  ShoppingItemController.swift
//  BearsDen
//
//  Created by James Neeley on 5/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation

class ShoppingItemController {
    static let shared = ShoppingItemController()
    
    func createShoppingItem(ForUser user: User, name: String) {
        
        let _ = ShoppingItem(name: name, isPurchased: false, user: user)
        
        UserController.shared.saveToCoreData()
        print("shopping item created")
    }
    
    
    func isPurchasedChangedFor(ShoppingItem item: ShoppingItem, isPurchased: Bool) {
        item.isPurchased = isPurchased
        UserController.shared.saveToCoreData()
    }
    
    func delete(ShoppingItem item: ShoppingItem) {
        item.managedObjectContext?.delete(item)
        UserController.shared.saveToCoreData()
    }
}

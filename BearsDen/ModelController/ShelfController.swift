//
//  ShelfController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation


class ShelfController {

    func createShelfForUser(User user: User, name: String) {
        let _ = Shelf(name: name, user: user)
        UserController.shared.saveToCoreData()
    }
    
    func delete(Shelf shelf: Shelf) {
        shelf.managedObjectContext?.delete(shelf)
        UserController.shared.saveToCoreData()
    }
    
    func update(Shelf shelf: Shelf, name: String) {
        shelf.name = name
        UserController.shared.saveToCoreData()
    }
    
}

//
//  ShelfController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

class ShelfController {
    
    static let shared = ShelfController()

    func createShelfForUser(User user: User, name: String) {
        let _ = Shelf(name: name, user: user)
        UserController.shared.saveToCoreData()
        print("shelf created")
        
        let request: NSFetchRequest<Shelf> = Shelf.fetchRequest()
        do {
            let users = try CoreDataStack.context.fetch(request)
            print(users.count)
        } catch {
            print("Error decoding data from filemanager: \(error), \(error.localizedDescription)")
        }
    
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

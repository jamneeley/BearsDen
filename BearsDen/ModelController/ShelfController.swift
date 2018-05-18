//
//  ShelfController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
import CoreData

class ShelfController {
    
    static let shared = ShelfController()

    func createShelfForUser(User user: User, name: String, photo: UIImage) {
        guard let image = UIImageJPEGRepresentation(photo, 1.0) else {return}
        let _ = Shelf(name: name, user: user, photo: image)
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
    
    func ChangePictureforShelf(Shelf shelf: Shelf, photo: UIImage) {
        let photoAsData = UIImagePNGRepresentation(photo)
        shelf.photo = photoAsData
        UserController.shared.saveToCoreData()
    }
    
    func updateName(Shelf shelf: Shelf, name: String) {
        shelf.name = name
        UserController.shared.saveToCoreData()
    }
}

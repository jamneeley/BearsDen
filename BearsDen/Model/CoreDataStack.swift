//
//  CoreDataStack.swift
//  BearsDen
//
//  Created by James Neeley on 5/1/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//


import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        // create container variable
        let container = NSPersistentContainer(name: "User")
        
        // and run all the code, loads persistant stores here and run a fatal error
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading from Core Data \(error)")
            }
        })
        return container
    }()
    //create the MOC
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}



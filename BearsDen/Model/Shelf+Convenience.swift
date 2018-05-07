//
//  Shelf.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData


extension Shelf {
    
    convenience init(name: String, user: User,  Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.name =  name
        self.user = user
        
    }
}

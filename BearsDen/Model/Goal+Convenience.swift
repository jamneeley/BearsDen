//
//  Goal.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension Goal {
    
    convenience init(name: String, creationDate: Date, completionDate: Date, user: User,  Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.name = name
        self.creationDate = creationDate
        self.completionDate =  completionDate
        self.user = user
    }
}

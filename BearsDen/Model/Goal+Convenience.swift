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
    
    convenience init(completionDate: Date, user: User,  Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.completionDate =  completionDate
        self.user = user
    }
}

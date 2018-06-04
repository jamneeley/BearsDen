//
//  User.swift
//  BearsDen
//
//  Created by James Neeley on 5/1/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension User {

    convenience init(houseHoldName: String, Context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: Context)
        self.houseHoldName = houseHoldName
    }
}

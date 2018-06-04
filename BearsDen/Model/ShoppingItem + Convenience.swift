//
//  ShoppingItem + Convenience.swift
//  BearsDen
//
//  Created by James Neeley on 5/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingItem {
    convenience init(name: String, isPurchased: Bool, user: User, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.user = user
        self.isPurchased = isPurchased
    }
}

//
//  GoalItem+Convenience.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension GoalItem {
    convenience init(category: String, unit: String, amount: String, goal: Goal, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.category = category
        self.unit = unit
        self.amount = amount
        self.goal = goal
    }
}


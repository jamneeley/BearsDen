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
    convenience init(category: String, unit: String, amount: String, goal: Goal, isCustom: Bool, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.category = category
        self.unit = unit
        self.amount = amount
        self.isCustom = isCustom
        self.isComplete = isComplete
        self.goal = goal
    }
}


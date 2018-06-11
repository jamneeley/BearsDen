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
    convenience init(goal: Goal, amount: String, isLiquid: Bool, category: String, unit: String, customText: String, isCustom: Bool, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.category = category
        self.unit = unit
        self.amount = amount
        self.isLiquid = isLiquid
        self.customText = customText
        self.isCustom = isCustom
        self.isComplete = isComplete
        self.goal = goal
    }
}


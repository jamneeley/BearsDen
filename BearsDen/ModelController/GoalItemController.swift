//
//  GoalItemController.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation

class GoalItemController {
    
    static let shared = GoalItemController()
    
    func create(GoalItemfor goal: Goal, category: String, unit: String, amount: String, customText: String, isCustom: Bool, isComplete: Bool ) {
        let _ = GoalItem(goal: goal, amount: amount, category: category, unit: unit, customText: customText, isCustom: isCustom, isComplete: isComplete)
        UserController.shared.saveToCoreData()
    }
    
    func changeIsCompleteFor(GoalItem item: GoalItem, to: Bool) {
        item.isComplete = to
        UserController.shared.saveToCoreData()
    }
    
    func update(GoalItem item: GoalItem, category: String, unit: String, amount: String) {
        item.category = category
        item.unit = unit
        item.amount = amount
        UserController.shared.saveToCoreData()
    }
    
    func delete(GoalItem item: GoalItem) {
        item.managedObjectContext?.delete(item)
        UserController.shared.saveToCoreData()
    }
}

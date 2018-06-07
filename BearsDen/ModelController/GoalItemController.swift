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
    
    func create(GoalItemfor goal: Goal, catagory: String, unit: String, amount: String ) {
        let _ = GoalItem(category: catagory, unit: unit, amount: amount, goal: goal)
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

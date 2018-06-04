//
//  GoalController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation

class GoalController {
    
    static let shared = GoalController()

    func createNewGoal(completionDate: Date, user: User) {
        let _ = Goal(completionDate: completionDate, user: user)
        UserController.shared.saveToCoreData()
    }
    
    func update(Goal goal: Goal, completionDate: Date) {
        goal.completionDate = completionDate
        UserController.shared.saveToCoreData()
    }
    
    func delete(Goal goal: Goal) {
        goal.managedObjectContext?.delete(goal)
        UserController.shared.saveToCoreData()
    }
}

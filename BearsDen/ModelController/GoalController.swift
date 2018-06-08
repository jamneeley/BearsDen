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

    func createNewGoal(name: String, creationDate: Date, completionDate: Date, user: User, completion: @escaping(Goal) -> Void) {
        let newGoal = Goal(name: name, creationDate: creationDate, completionDate: completionDate, user: user)
        completion(newGoal)
        UserController.shared.saveToCoreData()
    }
    
    func update(Goal goal: Goal, name: String, completionDate: Date) {
        goal.name = name
        goal.completionDate = completionDate
        UserController.shared.saveToCoreData()
    }
    
    func delete(Goal goal: Goal) {
        goal.managedObjectContext?.delete(goal)
        UserController.shared.saveToCoreData()
    }
}

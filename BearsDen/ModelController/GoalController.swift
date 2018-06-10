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
    
    func removeAllGoalItems(forGoal goal: Goal) {
        guard let goalItemSet = goal.goalItems else {return}
        if let goals = goalItemSet.allObjects as? [GoalItem] {
            for i in goals {
                GoalItemController.shared.delete(GoalItem: i)
            }
        }
    }
    
    func update(Goal goal: Goal, name: String, completionDate: Date) {
        goal.name = name
        goal.completionDate = completionDate
        UserController.shared.saveToCoreData()
    }
    
    func delete(Goal goal: Goal) {
        goal.managedObjectContext?.delete(goal)
        print("Goal Deleted")
        UserController.shared.saveToCoreData()
        
    }
    
    func calculateCompletionOf(Goal goal: Goal) -> Float {
        guard let goalItemSet = goal.goalItems else {print("goalItems didnt exist"); return Float(0.0)}
        
        var totalGoalPercentAmounts: Float = 0.0
        var numberOfGoalItems = 0
        
        
        //if NSSET can be converted to array of goalItems
        if let goalItems = goalItemSet.allObjects as? [GoalItem] {
            numberOfGoalItems = goalItems.count
            if !goalItems.isEmpty {
                //iterate through all the goal items
                for item in goalItems {
                    //unwrapp category and amount
                    if !item.isCustom {
                        if let category = item.category, let goalAmount = item.amount {
                            //Can goal amount be converted to Float?
                            if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: goalAmount)) {
                                let goalTotal = Float(goalAmount)!
                                let totalStored = findAmountStoredFor(Category: category)
                                let itemPercent = totalStored / goalTotal
                                if itemPercent < 1 {
                                    totalGoalPercentAmounts += itemPercent
                                } else {
                                    totalGoalPercentAmounts += 1
                                }
                            }
                        }
                    }
                }
            }
        } else {
            print("calculateCompletionOfGoal NSSet not converted to [goalItem]")
        }
        let percent = totalGoalPercentAmounts / Float(numberOfGoalItems)
        if !percent.isNaN {
            return percent
        } else {
            return Float(0)
        }
    }
    
    
    func findAmountStoredFor(Category category: String)  -> Float {
        
        
        
        
        return Float(50)
    }
}













































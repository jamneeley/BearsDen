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
                    //unwrapp category,  unit,  and amount
                    if !item.isCustom {
                        if let category = item.category, let goalAmount = item.amount, let unit = item.unit {
                            //Can goal amount be converted to Float?
                            if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: goalAmount)) {
                                let goalTotal = Float(goalAmount)!
                                var totalStored: Float = 0
                                
    
                                if item.isLiquid {
                                    totalStored = findAmountStoredFor(Category: category, inGoalUnits: unit, isGoalLiquid: true)
                                } else {
                                    totalStored = findAmountStoredFor(Category: category, inGoalUnits: unit, isGoalLiquid: false)
                                }
                                
                                let itemCompletionFraction = totalStored / goalTotal
                                //make sure that if the user has more stored in one item that it doesnt skew the data
                                if itemCompletionFraction < 1 {
                                    totalGoalPercentAmounts += itemCompletionFraction
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
    
    
    func findAmountStoredFor(Category category: String, inGoalUnits: String, isGoalLiquid: Bool)  -> Float {
        var totalStoredForCategory: Float = 0.0
        let shelvesOrderedSet = UserController.shared.user?.shelves
        //make sure NSOrderedSet can be converted
        guard let shelves = shelvesOrderedSet?.array as? [Shelf] else {return 0}
        for shelf in shelves {
            let itemsOrderedSet = shelf.items
            //make sure NSOrderedSet can be converted
            guard let items = itemsOrderedSet?.array as? [Item] else {return 0}
            for item in items {
                //make sure the category is the same and unwrapp unit
                if item.catagory == category, let itemUnit = item.unit {
                    //make sure item.weight can be converted to float
                    if let weight = item.weight, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: weight)){
                        //make sure goalunit and itemunit can be converted to each other....this means that the user has to make sure they are storing units correctly for their goals to ne accurate
                        if isGoalLiquid == item.isLiquid {
                            //multiply weight of item by the quantity
                            let totalWeight = Float(weight)! * Float(item.quantity)
                            //convert the totalweight to goal unit
                            let totalAmountInCorrectUnits = convert(Amount: totalWeight, FromItemUnit: itemUnit, GoalUnit: inGoalUnits, isLiquid: isGoalLiquid)
                            //add it to method property and then return it after loops
                            totalStoredForCategory += Float(totalAmountInCorrectUnits)
                            
                        }
                    }
                }
            }
        }
        return totalStoredForCategory
    }
    
    
    func convert(Amount amount: Float, FromItemUnit itemUnit: String, GoalUnit goalUnit: String, isLiquid: Bool) -> Float {
        let pound = "lb."
        let ounce = "oz."
        let gallon = "gal."
        let fluidOunce = "fl. oz."
        
        
        if isLiquid {
            if itemUnit == fluidOunce{
                if goalUnit == gallon {
                    let flOz = Measurement(value: Double(amount), unit: UnitVolume.fluidOunces)
                    let gallonConversion = flOz.converted(to: UnitVolume.gallons)
                    return Float(gallonConversion.value)
                } else {
                    //amount is already in fluidOunces
                    return amount
                }
            //item unit must equal gallons
            }else {
                if goalUnit == fluidOunce {
                    let gallons = Measurement(value: Double(amount), unit: UnitVolume.gallons)
                    let flOzConversion = gallons.converted(to: UnitVolume.fluidOunces)
                    return Float(flOzConversion.value)
                } else {
                    //amount is already in gallons
                    return amount
                }
            }
        } else {
            if itemUnit == ounce {
                if goalUnit == pound {
                    let oz = Measurement(value: Double(amount), unit: UnitMass.ounces)
                    let lb = oz.converted(to: UnitMass.pounds)
                    return Float(lb.value)
                } else {
                    //amount is already in ounces
                    return amount
                }
            // item unit must = pount
            }else {
                if goalUnit == ounce {
                    let lb = Measurement(value: Double(amount), unit: UnitMass.pounds)
                    let oz = lb.converted(to: UnitMass.ounces)
                    return Float(oz.value)
                } else {
                    //amount is already in pounds
                    return amount
                }
            }
        }
    }
}











































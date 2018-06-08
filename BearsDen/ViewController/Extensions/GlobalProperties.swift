//
//  Colors.swift
//  TestPractice
//
//  Created by James Neeley on 4/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

struct Colors {
    static let softBlue = UIColor(red: 0.0/255.0, green: 115.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let green = UIColor(red: 89.0/255.0, green: 189.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    static let yellow = UIColor(red: 244.0/255.0, green: 186.0/255.0, blue: 48.0/255, alpha: 1.0)
    static let veryLightGray = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    static let lightGray = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    static let mediumGray = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    static let darkGray = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    static let clear = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0)
    static let white = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}

struct CornerRadius {
    static let imageView: CGFloat = 15
    static let textField: CGFloat = 12
}

struct PickerViewProperties {
    static let units: [String] = ["lb.", "oz.", "gal.", "fl. oz."]
    static let catagories: [String] = ["Other", "Grain", "Protein", "Fruit", "Vegetable", "Legume", "Dairy", "Sugar", "Leavening", "Salt", "Fat", "Water", "Medical"]
}

struct GoalDetailItem {
    
    let name: String
    var isSelected: Bool

}

struct GoalItemList {
    static let possibleItemsForCells: [GoalDetailItem] = {
        var custom = GoalDetailItem(name: "Custom", isSelected: false)
        var grain = GoalDetailItem(name: "Grain", isSelected: false)
        var protien = GoalDetailItem(name: "Protein", isSelected: false)
        var fruit = GoalDetailItem(name: "Fruit", isSelected: false)
        var vegetable = GoalDetailItem(name: "Vegetable", isSelected: false)
        var legume = GoalDetailItem(name: "Legume", isSelected: false)
        var dairy = GoalDetailItem(name: "Dairy", isSelected: false)
        var sugar = GoalDetailItem(name: "Sugar", isSelected: false)
        var leavening = GoalDetailItem(name: "Leavening", isSelected: false)
        var salt = GoalDetailItem(name: "Salt", isSelected: false)
        var fat = GoalDetailItem(name: "Fat", isSelected: false)
        var water = GoalDetailItem(name: "Water", isSelected: false)
        var medical = GoalDetailItem(name: "Medical", isSelected: false)
        
        return [custom, grain, protien, fruit, vegetable, legume, dairy, sugar, leavening, salt, fat, water, medical]
    }()
}











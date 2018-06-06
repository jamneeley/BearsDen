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
    static let units: [String] = ["lb.", "oz.", "gal."]
    static let catagories: [String] = ["Grain", "Legume", "Dairy", "Sugar", "Leavening", "Salt", "Fat", "Water", "Protein", "Fruit", "Vegetable", "Medical", "Other"]
}

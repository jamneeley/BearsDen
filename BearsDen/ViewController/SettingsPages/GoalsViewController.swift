//
//  GoalsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController {
    
    let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension GoalsViewController {
    func setupLabel() {
        view.addSubview(testLabel)
        testLabel.text = "Goals"
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
}


// BASIC FOOD STORAGE RECOMMENDATIONS
/*                      Adult/Week                          Kid/Week
 Grains                 7.692 lbs                           4.9998 lbs
 Legumes                1.154 lbs                           .7501  lbs
 Dairy Products         .576  lbs                           .3744  lbs
 Sugars                 1.154 lbs                           .7501  lbs
 Leavening Agents       .115  lbs                           .0748  lbs
 Salt                   .115  lbs                           .0748  lbs
 Fats                   .577  lbs                           .3750  lbs
 Water                  14    Gallons                       14 Gallons
 
 
 */

//Grain (includes wheat, white rice, oats, corn, barley, pasta, etc.):
//Legumes (dried beans, split peas, lentils, nuts, etc.):
//Dairy Products (powdered milk, cheese powdercheese powder, canned cheese, etc.):
//Sugars (white sugar, brown sugar, syrup, molasses, honey, etc.):
//Leavening Agents (Yeast, baking powder, powdered eggs, etc.):
//Salt (Table salt, sea salt, soy sauce, bouillon, etc.):
//Fats (Vegetable oils, shortening, canned butter, etc.):

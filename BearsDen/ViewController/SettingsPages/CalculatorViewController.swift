//
//  CalculatorViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    let singleTap = UITapGestureRecognizer()
    let instructionLabel = UILabel()
    let labelStack = UIStackView()
    let numbersStack = UIStackView()
    let variablesStack =  UIStackView()
    let adultTextLabel = UILabel()
    let adultNumberLabel = UILabel()
    let kidsTextLabel = UILabel()
    let kidNumberLabel = UILabel()
    let weeksLabel = UILabel()
    let weeksTextField = UITextField()
    
    let calculateButton = UIButton(type: .custom)
    let scrollView = UIScrollView()
    let contentView = UIView()
    let scrollViewSeperator = UIView()
    let mainCalculatorStack = UIStackView()
    let itemCatagoryStack = UIStackView()
    let totalQuantityStack = UIStackView()
    let exampleStack = UIStackView()
    
    let grainsLabel = UILabel()
    let legumesLabel = UILabel()
    let dairyLabel = UILabel()
    let sugarLabel = UILabel()
    let leaveningAgentsLabel = UILabel()
    let saltLabel = UILabel()
    let fatsLabel = UILabel()
    let waterLabel = UILabel()
    
    let grainsAmountLabel = UILabel()
    let legumesAmountLabel = UILabel()
    let dairyAmountLabel = UILabel()
    let sugarAmountLabel = UILabel()
    let leaveningAgentsAmountLabel = UILabel()
    let saltAmountLabel = UILabel()
    let fatsAmountLabel = UILabel()
    let waterAmountLabel = UILabel()
    
    let seperator = UIView()

    let grainsExampleLabel = UILabel()
    let legumesExampleLabel = UILabel()
    let dairyExampleLabel = UILabel()
    let sugarExampleLabel = UILabel()
    let leaveningAgentsExampleLabel = UILabel()
    let saltExampleLabel = UILabel()
    let fatsExampleLabel = UILabel()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        setupObjects()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateLabels()
    }
    
    func updateLabels() {
        let adults = UserController.shared.user?.adults ?? "0"
        let kids = UserController.shared.user?.kids ?? "0"
        adultNumberLabel.text = adults
        kidNumberLabel.text = kids
    }
    
    //MARK: - Setup
    
    func setupObjects() {
        setupSingleTap()
        setupInstructionLabel()
        setupVariablesStack()
        setupLabelStack()
        setupNumbersStack()
        setupWeeksTextField()
        setupCalculateButton()
        setupScrollView()
        setupContentView()
        setupScrollView()
        setupScrollViewSeperator()
        setupContentView()
        setupMainCalculatorStack()
        setupItemCatagoryStack()
        setupTotalQuantityStack()
        setupSeperator()
        setupExampleStack()
    }
    
    //MARK: - Top of Calculator
    //setup
    
    func setupSingleTap() {
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(disableKeyBoard))
    }
    
    func setupInstructionLabel() {
        view.addSubview(instructionLabel)
        instructionLabel.text = "* Change household size in \"Settings\"\n* Calculations are based off national averages"
        instructionLabel.textColor = Colors.verydarkGray
        instructionLabel.font = UIFont.boldSystemFont(ofSize: 10)
        instructionLabel.textAlignment = .center
        setupInstructionLabelConstraints()
        instructionLabel.numberOfLines = 2
    }
    
    func setupVariablesStack() {
        view.addSubview(variablesStack)
        variablesStack.addArrangedSubview(labelStack)
        variablesStack.addArrangedSubview(numbersStack)
        variablesStack.axis = .horizontal
        variablesStack.distribution = .fillEqually
        setupVariableStackConstraints()
    }
    
    func setupLabelStack() {
        labelStack.addArrangedSubview(adultTextLabel)
        labelStack.addArrangedSubview(kidsTextLabel)
        labelStack.addArrangedSubview(weeksLabel)
        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
    }
    
    func setupNumbersStack() {
        numbersStack.addArrangedSubview(adultNumberLabel)
        numbersStack.addArrangedSubview(kidNumberLabel)
        numbersStack.addArrangedSubview(weeksTextField)
        weeksTextField.keyboardType = .decimalPad
        numbersStack.axis = .vertical
        numbersStack.distribution = .fillEqually
        adultTextLabel.text = "Adults"
        kidsTextLabel.text = "Kids"
        weeksLabel.text = "Weeks"
    }

    func setupWeeksTextField() {
        let adults = UserController.shared.user?.adults ?? "0"
        let kids = UserController.shared.user?.kids ?? "0"
        adultNumberLabel.text = adults
        kidNumberLabel.text = kids
        weeksTextField.placeholder = "0"
        weeksTextField.backgroundColor = .white
        weeksTextField.layer.borderWidth = 2
        weeksTextField.layer.borderColor = Colors.softBlue.cgColor
        weeksTextField.layer.cornerRadius = 12
        weeksTextField.setLeftPaddingPoints(10)
        weeksTextField.setRightPaddingPoints(10)
    }
    
    func setupCalculateButton() {
        view.addSubview(calculateButton)
        calculateButton.frame = CGRect(x: view.frame.width * 0.7, y: view.frame.height * 0.2 - 80, width: 80, height: 80)
        calculateButton.backgroundColor = Colors.green
        calculateButton.setImage(#imageLiteral(resourceName: "calculatorButton"), for: .normal)
        calculateButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        calculateButton.layer.cornerRadius = calculateButton.frame.width / 2
        calculateButton.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        calculateButton.addTarget(self, action: #selector(endHighlight), for: .touchUpOutside)
        calculateButton.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
    }
    
    //constraints
    
    func setupInstructionLabelConstraints() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * 0.05).isActive = true
        instructionLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
    }
    
    func setupVariableStackConstraints() {
        variablesStack.translatesAutoresizingMaskIntoConstraints = false
        variablesStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05).isActive = true
        variablesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        variablesStack.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        variablesStack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2).isActive = true
    }
    
    //MARK: -Scroll View
    
    func setupScrollViewSeperator() {
        view.addSubview(scrollViewSeperator)
        scrollViewSeperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        scrollViewSeperator.translatesAutoresizingMaskIntoConstraints = false
        scrollViewSeperator.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -2).isActive = true
        scrollViewSeperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollViewSeperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollViewSeperator.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .black
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: variablesStack.bottomAnchor, constant: view.frame.height * 0.05).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0 ).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 2.5).isActive = true
    }
    
    func setupMainCalculatorStack() {
        contentView.addSubview(mainCalculatorStack)
        mainCalculatorStack.addArrangedSubview(itemCatagoryStack)
        mainCalculatorStack.addArrangedSubview(totalQuantityStack)
        mainCalculatorStack.axis = .horizontal
        mainCalculatorStack.distribution = .fillEqually
        mainCalculatorStack.translatesAutoresizingMaskIntoConstraints = false
        mainCalculatorStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        mainCalculatorStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        mainCalculatorStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        mainCalculatorStack.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -view.frame.height * 0.8).isActive = true
    }
    
    func setupItemCatagoryStack() {
        itemCatagoryStack.addArrangedSubview(grainsLabel)
        itemCatagoryStack.addArrangedSubview(legumesLabel)
        itemCatagoryStack.addArrangedSubview(dairyLabel)
        itemCatagoryStack.addArrangedSubview(sugarLabel)
        itemCatagoryStack.addArrangedSubview(leaveningAgentsLabel)
        itemCatagoryStack.addArrangedSubview(saltLabel)
        itemCatagoryStack.addArrangedSubview(fatsLabel)
        itemCatagoryStack.addArrangedSubview(waterLabel)
        itemCatagoryStack.axis = .vertical
        itemCatagoryStack.distribution = .fillEqually
        
        grainsLabel.text = "Grains"
        legumesLabel.text = "Legumes"
        dairyLabel.text = "Dairy"
        sugarLabel.text = "Sugar"
        leaveningAgentsLabel.text = "Leavening Agents"
        saltLabel.text = "Salt"
        fatsLabel.text = "Fats"
        waterLabel.text = "Water"
    }
    
    func setupTotalQuantityStack() {
        totalQuantityStack.addArrangedSubview(grainsAmountLabel)
        totalQuantityStack.addArrangedSubview(legumesAmountLabel)
        totalQuantityStack.addArrangedSubview(dairyAmountLabel)
        totalQuantityStack.addArrangedSubview(sugarAmountLabel)
        totalQuantityStack.addArrangedSubview(leaveningAgentsAmountLabel)
        totalQuantityStack.addArrangedSubview(saltAmountLabel)
        totalQuantityStack.addArrangedSubview(fatsAmountLabel)
        totalQuantityStack.addArrangedSubview(waterAmountLabel)
        
        grainsAmountLabel.textAlignment = .right
        legumesAmountLabel.textAlignment = .right
        dairyAmountLabel.textAlignment = .right
        sugarAmountLabel.textAlignment = .right
        leaveningAgentsAmountLabel.textAlignment = .right
        saltAmountLabel.textAlignment = .right
        fatsAmountLabel.textAlignment = .right
        waterAmountLabel.textAlignment = .right
        
        grainsAmountLabel.text = "0 lb"
        legumesAmountLabel.text = "0 lb"
        dairyAmountLabel.text = "0 lb"
        sugarAmountLabel.text = "0 lb"
        leaveningAgentsAmountLabel.text = "0 lb"
        saltAmountLabel.text = "0 lb"
        fatsAmountLabel.text = "0 lb"
        waterAmountLabel.text = "0 gal"
        
        totalQuantityStack.axis = .vertical
        totalQuantityStack.distribution = .fillEqually
    }
    
    func setupSeperator() {
        contentView.addSubview(seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.topAnchor.constraint(equalTo: mainCalculatorStack.bottomAnchor, constant: 20).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.2).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.2).isActive = true
        seperator.bottomAnchor.constraint(equalTo: mainCalculatorStack.bottomAnchor, constant: 22).isActive = true
    }

    
    func setupExampleStack() {
        contentView.addSubview(exampleStack)
        
        
        
        
        
        exampleStack.addArrangedSubview(grainsExampleLabel)
        exampleStack.addArrangedSubview(legumesExampleLabel)
        exampleStack.addArrangedSubview(dairyExampleLabel)
        exampleStack.addArrangedSubview(sugarExampleLabel)
        exampleStack.addArrangedSubview(leaveningAgentsExampleLabel)
        exampleStack.addArrangedSubview(saltExampleLabel)
        exampleStack.addArrangedSubview(fatsExampleLabel)
        exampleStack.axis = .vertical
        exampleStack.distribution = .fillEqually
        
        grainsExampleLabel.text = "*  Grain (includes wheat, white rice, oats, corn, barley, pasta, etc.)"
        legumesExampleLabel.text = "*  Legumes (dried beans, split peas, lentils, nuts, etc.)"
        dairyExampleLabel.text = "*  Dairy Products (powdered milk, cheese powdercheese powder, canned cheese, etc.)"
        sugarExampleLabel.text = "*  Sugars (white sugar, brown sugar, syrup, molasses, honey, etc.)"
        leaveningAgentsExampleLabel.text = "*  Leavening Agents (Yeast, baking powder, powdered eggs, etc.)"
        saltExampleLabel.text = "*  Salt (Table salt, sea salt, soy sauce, bouillon, etc.)"
        fatsExampleLabel.text = "*  Fats (Vegetable oils, shortening, canned butter, etc.)"
        

        grainsExampleLabel.numberOfLines = 0
        legumesExampleLabel.numberOfLines = 0
        dairyExampleLabel.numberOfLines = 0
        sugarExampleLabel.numberOfLines = 0
        leaveningAgentsExampleLabel.numberOfLines = 0
        saltExampleLabel.numberOfLines = 0
        fatsExampleLabel.numberOfLines = 0
        
        exampleStack.translatesAutoresizingMaskIntoConstraints = false
        exampleStack.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20).isActive = true
        exampleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        exampleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        exampleStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.frame.height * -0.04).isActive = true
    }
    
    //MARK: - KeyBoard methods
    
    @objc func disableKeyBoard() {
        view.endEditing(true)
    }
    
    @objc func keyBoardWillShow() {
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func keyBoardWillHide() {
        view.addGestureRecognizer(singleTap)
    }
    
    //MARK: - Button Methods
    
    @objc func startHighlight() {
        calculateButton.backgroundColor = Colors.softBlue
    }
    
    @objc func endHighlight() {
        calculateButton.backgroundColor = Colors.green
    }
    
    @objc func calculateButtonPressed() {
        endHighlight()
        disableKeyBoard()
        guard let weeksString = weeksTextField.text, !weeksString.isEmpty else {presentAlert(Title: "Uh Oh", message: "You'll need to enter an amount for \"Weeks\""); return}
        
            let adultsString = UserController.shared.user?.adults ?? "0"
            let kidsString = UserController.shared.user?.kids ?? "0"
        
        
        if weeksString.isDouble, adultsString.isDouble, kidsString.isDouble {
            
            guard let weeks = Double(weeksString),
                let adults = Double(adultsString),
                let kids = Double(kidsString)
                else {return}
            
            let grainsAmount = ((7.692 * weeks * adults) + (4.9998 * weeks * kids)).roundToPlaces(places: 1)
            let legumesAmount = ((1.154 * weeks * adults) + (0.7501 * weeks * kids)).roundToPlaces(places: 1)
            let dairyAmount = ((0.576 * weeks * adults) + (0.3744 * weeks * kids)).roundToPlaces(places: 1)
            let sugarAmount = ((1.154 * weeks * adults) + (0.7501 * weeks * kids)).roundToPlaces(places: 1)
            let leaveningAgent = ((0.115 * weeks * adults) + (0.0748 * weeks * kids)).roundToPlaces(places: 1)
            let saltAmount = ((0.115 * weeks * adults) + (0.0748 * weeks * kids)).roundToPlaces(places: 1)
            let fatsAmount = ((0.577 * weeks * adults) + (0.375 * weeks * kids)).roundToPlaces(places: 1)
            let waterAmount = ((14 * weeks * adults) + (14 * weeks * kids)).roundToPlaces(places: 1)
            
            grainsAmountLabel.text = "\(grainsAmount) Lbs"
            legumesAmountLabel.text = "\(legumesAmount) Lbs"
            dairyAmountLabel.text = "\(dairyAmount) Lbs"
            sugarAmountLabel.text = "\(sugarAmount) Lbs"
            leaveningAgentsAmountLabel.text = "\(leaveningAgent) Lbs"
            saltAmountLabel.text = "\(saltAmount) Lbs"
            fatsAmountLabel.text = "\(fatsAmount) Lbs"
            waterAmountLabel.text = "\(waterAmount) Gal"
        }
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








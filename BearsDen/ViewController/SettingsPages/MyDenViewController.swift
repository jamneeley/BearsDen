//
//  MyDenViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MyDenViewController: UIViewController {
    
    let denNameLabel = UILabel()
    
    let mainView = UIView()
    
    let mainStack = UIStackView()
    
    let totalLabel = UILabel()
    let seperator = UIView()
    
    let grainLabel = UILabel()
    let grainAmountLabel = UILabel()
    let grainStack = UIStackView()
    
    let protienLabel = UILabel()
    let protienAmountLabel = UILabel()
    let protienStack = UIStackView()
    
    let fruitLabel = UILabel()
    let fruitAmountLabel = UILabel()
    let fruitStack = UIStackView()
    
    let vegetableLabel = UILabel()
    let vegetableAmountLabel = UILabel()
    let vegetableStack = UIStackView()
    
    let legumeLabel = UILabel()
    let legumeAmountLabel = UILabel()
    let legumeStack = UIStackView()
    
    let dairyLabel = UILabel()
    let dairyAmountLabel = UILabel()
    let dairyStack = UIStackView()
    
    let sugarLabel = UILabel()
    let sugarAmountLabel = UILabel()
    let sugarStack = UIStackView()
    
    let leaveningLabel = UILabel()
    let leaveningAmountLabel = UILabel()
    let leaveningStack = UIStackView()
    
    let saltLabel = UILabel()
    let saltAmountLabel = UILabel()
    let saltStack = UIStackView()
    
    let fatLabel = UILabel()
    let fatAmountLabel = UILabel()
    let fatStack = UIStackView()
    
    let waterLabel = UILabel()
    let waterAmountLabel = UILabel()
    let waterStack = UIStackView()
    
    let medicalLabel = UILabel()
    let medicalAmountLabel = UILabel()
    let medicalStack = UIStackView()
    
    let otherLabel = UILabel()
    let otherAmountLabel = UILabel()
    let otherStack = UIStackView()
    
    let grainString = PickerViewProperties.catagories[1]
    let protienString = PickerViewProperties.catagories[2]
    let fruitString = PickerViewProperties.catagories[3]
    let vegetableString = PickerViewProperties.catagories[4]
    let legumeString = PickerViewProperties.catagories[5]
    let dairyString = PickerViewProperties.catagories[6]
    let sugarString = PickerViewProperties.catagories[7]
    let leaveningString = PickerViewProperties.catagories[8]
    let saltString = PickerViewProperties.catagories[9]
    let fatString = PickerViewProperties.catagories[10]
    let waterString = PickerViewProperties.catagories[11]
    let medicalString = PickerViewProperties.catagories[12]
    let otherString = PickerViewProperties.catagories[0]
    
    let pounds = PickerViewProperties.units[0]
    let gallon = PickerViewProperties.units[2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        setupObjects()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        calculateTotals()
    }
    
    func calculateTotals() {
        let grains = GoalController.shared.findAmountStoredFor(Category: grainString, inGoalUnits: pounds, isGoalLiquid: false)
        let protien = GoalController.shared.findAmountStoredFor(Category: protienString, inGoalUnits: pounds, isGoalLiquid: false)
        let fruit = GoalController.shared.findAmountStoredFor(Category: fruitString, inGoalUnits: pounds, isGoalLiquid: false)
        let vegetable = GoalController.shared.findAmountStoredFor(Category: vegetableString, inGoalUnits: pounds, isGoalLiquid: false)
        let legume = GoalController.shared.findAmountStoredFor(Category: legumeString, inGoalUnits: pounds, isGoalLiquid: false)
        let dairy = GoalController.shared.findAmountStoredFor(Category: dairyString, inGoalUnits: pounds, isGoalLiquid: false)
        let sugar = GoalController.shared.findAmountStoredFor(Category: sugarString, inGoalUnits: pounds, isGoalLiquid: false)
        let leavening = GoalController.shared.findAmountStoredFor(Category: leaveningString, inGoalUnits: pounds, isGoalLiquid: false)
        let salt = GoalController.shared.findAmountStoredFor(Category: saltString, inGoalUnits: pounds, isGoalLiquid: false)
        let fat = GoalController.shared.findAmountStoredFor(Category: fatString, inGoalUnits: pounds, isGoalLiquid: false)
        let water = GoalController.shared.findAmountStoredFor(Category: waterString, inGoalUnits: gallon, isGoalLiquid: true)
        let medical = GoalController.shared.findAmountStoredFor(Category: medicalString, inGoalUnits: pounds, isGoalLiquid: false)
        let other = GoalController.shared.findAmountStoredFor(Category: otherString, inGoalUnits: pounds, isGoalLiquid: false)
        
        grainAmountLabel.text = grains != 0 ? "\(Int(grains)) lbs" : "-"
        protienAmountLabel.text = protien != 0 ? "\(Int(protien)) lbs" : "-"
        fruitAmountLabel.text = fruit != 0 ? "\(Int(fruit)) lbs" : "-"
        vegetableAmountLabel.text = vegetable != 0 ? "\(Int(vegetable)) lbs" : "-"
        legumeAmountLabel.text = legume != 0 ? "\(Int(legume)) lbs" : "-"
        dairyAmountLabel.text = dairy != 0 ? "\(Int(dairy)) lbs" : "-"
        sugarAmountLabel.text = sugar != 0 ? "\(Int(sugar)) lbs" : "-"
        leaveningAmountLabel.text = leavening != 0 ? "\(Int(leavening)) lbs" : "-"
        saltAmountLabel.text = salt != 0 ? "\(Int(salt)) lbs" : "-"
        fatAmountLabel.text = fat != 0 ? "\(Int(fat)) lbs" : "-"
        waterAmountLabel.text = water != 0 ? "\(Int(water)) gal" : "-"
        medicalAmountLabel.text = medical != 0 ? "\(Int(medical)) lbs" : "-"
        otherAmountLabel.text = other != 0 ? "\(Int(other)) lbs" : "-"
    }

    func setupObjects() {
        setupMainView()
        setupNameLabel()
        setupTotalLabel()
        setupSeperator()
        setupMainStack()
        setupGrainStack()
        setupProtienStack()
        setupFruitStack()
        setupVegetableStack()
        setupLegumeStack()
        setupDairyStack()
        setupSugarStack()
        setupLeaveningStack()
        setupSaltStack()
        setupFatStack()
        setupWaterStack()
        setupMedicalStack()
        setupOtherStack()
    }
    
    func setupMainView() {
        view.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = CornerRadius.imageView
        mainView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.85, height: view.frame.height * 0.85)
        mainView.dropShadow()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.04).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.08).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.08).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height * -0.04).isActive = true
    }
    
    func setupNameLabel() {
        mainView.addSubview(denNameLabel)
        let houseHoldName = UserController.shared.user?.houseHoldName ?? "My Den"
        denNameLabel.text = houseHoldName
        denNameLabel.textAlignment = .center
        denNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        denNameLabel.translatesAutoresizingMaskIntoConstraints = false
        denNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: mainView.frame.height * 0.03).isActive = true
        denNameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: mainView.frame.width * 0.02).isActive = true
        denNameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: mainView.frame.width * -0.02).isActive = true
        denNameLabel.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: mainView.frame.width * 0.15).isActive = true
    }
    
    func setupMainStack() {
        mainView.addSubview(mainStack)
        mainStack.axis = .vertical
        mainStack.distribution = .fillProportionally
        mainStack.spacing = 2
        mainStack.addArrangedSubview(totalLabel)
        mainStack.addArrangedSubview(seperator)
        mainStack.addArrangedSubview(grainStack)
        mainStack.addArrangedSubview(protienStack)
        mainStack.addArrangedSubview(fruitStack)
        mainStack.addArrangedSubview(vegetableStack)
        mainStack.addArrangedSubview(legumeStack)
        mainStack.addArrangedSubview(dairyStack)
        mainStack.addArrangedSubview(sugarStack)
        mainStack.addArrangedSubview(leaveningStack)
        mainStack.addArrangedSubview(saltStack)
        mainStack.addArrangedSubview(fatStack)
        mainStack.addArrangedSubview(waterStack)
        mainStack.addArrangedSubview(medicalStack)
        mainStack.addArrangedSubview(otherStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: denNameLabel.bottomAnchor, constant: mainView.frame.height * 0.05).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: mainView.frame.width * 0.05).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: mainView.frame.width * -0.05).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: mainView.frame.height * -0.05).isActive = true
    }
    
    func setupTotalLabel() {
        totalLabel.textAlignment = .right
        totalLabel.text = "Totals"
        totalLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func setupSeperator() {
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
    }
    
    func setupGrainStack() {
        grainStack.addArrangedSubview(grainLabel)
        grainStack.addArrangedSubview(grainAmountLabel)
        grainStack.axis = .horizontal
        grainStack.distribution = .fillEqually
        grainLabel.text = "Grains"
        grainAmountLabel.textAlignment = .right
        grainStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupProtienStack() {
        protienStack.addArrangedSubview(protienLabel)
        protienStack.addArrangedSubview(protienAmountLabel)
        protienStack.axis = .horizontal
        protienStack.distribution = .fillEqually
        protienLabel.text = "Protien"
        protienAmountLabel.textAlignment = .right
        protienStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupFruitStack() {
        fruitStack.addArrangedSubview(fruitLabel)
        fruitStack.addArrangedSubview(fruitAmountLabel)
        fruitStack.axis = .horizontal
        fruitStack.distribution = .fillEqually
        fruitLabel.text = "Fruit"
        fruitAmountLabel.textAlignment = .right
        fruitStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupVegetableStack() {
        vegetableStack.addArrangedSubview(vegetableLabel)
        vegetableStack.addArrangedSubview(vegetableAmountLabel)
        vegetableStack.axis = .horizontal
        vegetableStack.distribution = .fillEqually
        vegetableLabel.text = "Vegetables"
        vegetableAmountLabel.textAlignment = .right
        vegetableStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupLegumeStack() {
        legumeStack.addArrangedSubview(legumeLabel)
        legumeStack.addArrangedSubview(legumeAmountLabel)
        legumeStack.axis = .horizontal
        legumeStack.distribution = .fillEqually
        legumeLabel.text = "Legumes"
        legumeAmountLabel.textAlignment = .right
        legumeStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupDairyStack() {
        dairyStack.addArrangedSubview(dairyLabel)
        dairyStack.addArrangedSubview(dairyAmountLabel)
        dairyStack.axis = .horizontal
        dairyStack.distribution = .fillEqually
        dairyLabel.text = "Dairy"
        dairyAmountLabel.textAlignment = .right
        dairyStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupSugarStack() {
        sugarStack.addArrangedSubview(sugarLabel)
        sugarStack.addArrangedSubview(sugarAmountLabel)
        sugarStack.axis = .horizontal
        sugarStack.distribution = .fillEqually
        sugarLabel.text = "Sugar"
        sugarAmountLabel.textAlignment = .right
        sugarStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupLeaveningStack() {
        leaveningStack.addArrangedSubview(leaveningLabel)
        leaveningStack.addArrangedSubview(leaveningAmountLabel)
        leaveningStack.axis = .horizontal
        leaveningStack.distribution = .fillEqually
        leaveningLabel.text = "Leavening"
        leaveningAmountLabel.textAlignment = .right
        leaveningStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func  setupSaltStack() {
        saltStack.addArrangedSubview(saltLabel)
        saltStack.addArrangedSubview(saltAmountLabel)
        saltStack.axis = .horizontal
        saltStack.distribution = .fillEqually
        saltLabel.text = "Salt"
        saltAmountLabel.textAlignment = .right
        saltStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupFatStack() {
        fatStack.addArrangedSubview(fatLabel)
        fatStack.addArrangedSubview(fatAmountLabel)
        fatStack.axis = .horizontal
        fatStack.distribution = .fillEqually
        fatLabel.text = "Fat"
        fatAmountLabel.textAlignment = .right
        fatStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupWaterStack() {
        waterStack.addArrangedSubview(waterLabel)
        waterStack.addArrangedSubview(waterAmountLabel)
        waterStack.axis = .horizontal
        waterStack.distribution = .fillEqually
        waterLabel.text = "Water"
        waterAmountLabel.textAlignment = .right
        waterStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupMedicalStack() {
        medicalStack.addArrangedSubview(medicalLabel)
        medicalStack.addArrangedSubview(medicalAmountLabel)
        medicalStack.axis = .horizontal
        medicalStack.distribution = .fillEqually
        medicalLabel.text = "Medical"
        medicalAmountLabel.textAlignment = .right
        medicalStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
    
    func setupOtherStack() {
        otherStack.addArrangedSubview(otherLabel)
        otherStack.addArrangedSubview(otherAmountLabel)
        otherStack.axis = .horizontal
        otherStack.distribution = .fillEqually
        otherLabel.text = "Other"
        otherAmountLabel.textAlignment = .right
        otherStack.heightAnchor.constraint(equalToConstant: view.frame.height * 0.045).isActive = true
    }
}


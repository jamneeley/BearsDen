//
//  ItemTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

protocol ItemCellDelegate: class {
    func addedToShoppingList(itemName: String)
}

class ItemTableViewCell: UITableViewCell {
    
    var item: Item? {
        didSet {
            setupViews()
        }
    }
    
    weak var delegate: ItemCellDelegate?
    
    let itemNameLabel = UILabel()
    let expirationDateLabel = UILabel()
    let quantityLabel = UILabel()
    let stockedLabel = UILabel()
    let barCodeLabel = UILabel()
    let quantityStepper = UIStepper()
    let addToShoppingListButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addSubview(itemNameLabel)
        addSubview(expirationDateLabel)
        addSubview(addToShoppingListButton)
        addSubview(stockedLabel)
        addSubview(quantityLabel)
        addSubview(quantityStepper)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-[v1]-10-[v2(45)]-10-|", views: itemNameLabel, expirationDateLabel, addToShoppingListButton)
        addConstraintsWithFormat(format: "V:|-5-[v0]-30-[v1]-5-[v2]-5-|", views: stockedLabel, quantityLabel, quantityStepper )
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: itemNameLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: expirationDateLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0(45)]", views: addToShoppingListButton)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: stockedLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: quantityLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: quantityStepper)

    }
    
    func setupViews() {
        setupButton()
        setupQuantityStepper()
        guard let item = item,
        let stocked = item.stocked,
        let expirationDate = item.expirationDate else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let itemQuantity = Int(item.quantity)
        backgroundColor = .white
        itemNameLabel.text = item.name
        expirationDateLabel.text = "Exp Date: \(dateFormatter.string(from: stocked))"
        stockedLabel.text = "Stocked: \(dateFormatter.string(from: expirationDate))"
        quantityLabel.text = "Quantity: \(itemQuantity)"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        expirationDateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        stockedLabel.font = UIFont.boldSystemFont(ofSize: 11)
        stockedLabel.textColor = Colors.mediumGray
    }
    

    
    func setupQuantityStepper() {
        guard let item = item else {return}
        quantityStepper.stepValue = 1
        quantityStepper.value = Double(item.quantity)
        quantityStepper.maximumValue = 1000.0
        quantityStepper.isContinuous = false
        quantityStepper.autorepeat = false
        quantityStepper.addTarget(self, action: #selector(beginHighlightStepper), for: .touchDown)
        quantityStepper.addTarget(self, action: #selector(stepperTouched), for: .touchUpInside)
        quantityStepper.addTarget(self, action: #selector(endHighlightStepper), for: .touchUpOutside)

    }
    
    func setupButton() {
        addToShoppingListButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addToShoppingListButton.setImage(#imageLiteral(resourceName: "shoppingCartX2"), for: .normal)
        addToShoppingListButton.backgroundColor = Colors.yellow
        addToShoppingListButton.layer.cornerRadius = 0.5 * addToShoppingListButton.frame.size.width
        addToShoppingListButton.addTarget(self, action: #selector(beginHighlightButton), for: .touchDown)
        addToShoppingListButton.addTarget(self, action: #selector(addToListButtonPressed), for: .touchUpInside)
        addToShoppingListButton.addTarget(self, action: #selector(endHighlightButton), for: .touchUpOutside)
        
    }
    
    @objc func beginHighlightStepper() {
    }
    @objc func endHighlightStepper() {
    }
    
    @objc func stepperTouched() {
        guard let item = item else {return}
        let itemQuantityDouble = quantityStepper.value
        let itemQuantity = Int(quantityStepper.value)
        quantityLabel.text = "Quantity: \(itemQuantity)"
        ItemController.shared.adjustQuantityFor(Item: item, quantity: itemQuantityDouble)
    }
    
    @objc func beginHighlightButton(){
        addToShoppingListButton.backgroundColor = Colors.softBlue
    }
    
    @objc func endHighlightButton() {
        addToShoppingListButton.backgroundColor = Colors.yellow
    }
    
    @objc func addToListButtonPressed() {
        endHighlightButton()
        guard let itemName = item?.name,
        let user = UserController.shared.user  else {return}
        ShoppingItemController.shared.createShoppingItem(ForUser: user, name: itemName)
        delegate?.addedToShoppingList(itemName: itemName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

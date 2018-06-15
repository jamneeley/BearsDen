//
//  ItemTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//
import UIKit

//MARK: - Delegate Protocol

protocol ItemCellDelegate: class {
    func addedToShoppingList(itemName: String)
}

class ItemTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    
    
    weak var delegate: ItemCellDelegate?
    
    let itemNameLabel = UILabel()
    let expirationDateLabel = UILabel()
    let quantityLabel = UILabel()
    let stockedLabel = UILabel()
    let weightLabel = UILabel()
    let categoryLabel = UILabel()
    let barCodeLabel = UILabel()
    let quantityStepper = UIStepper()
    let addToShoppingListButton = UIButton()
    
    //Settable Properties
    
    var item: Item? {
        didSet {
            setupViews()
        }
    }
    
    //MARK: - Cell Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        selectionStyle = .blue
        let selectionView = UIView()
        selectionView.backgroundColor = Colors.softBlue
        selectedBackgroundView = selectionView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Button Methods
    @objc func stepperTouched() {
        guard let item = item else {return}
        let itemQuantityDouble = quantityStepper.value
        let itemQuantity = Double(quantityStepper.value)
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

    
///////////////////////////
//MARK: - Views
///////////////////////////
    
    func setupViews() {
        backgroundColor = .white
        addViewsToSuperView()
        setupItemDependentLabelProperties()
        setupQuantityStepper()
        setupAddToShoppingListButton()
        setupLabelsProperties()
        setupConstraints()
    }
    
    func addViewsToSuperView() {
        addSubview(itemNameLabel)
        addSubview(expirationDateLabel)
        addSubview(weightLabel)
        addSubview(categoryLabel)
        addSubview(addToShoppingListButton)
        addSubview(stockedLabel)
        addSubview(quantityLabel)
        addSubview(quantityStepper)
    }
    
    func setupItemDependentLabelProperties() {
        guard let item = item,
            let stocked = item.stocked,
            let expirationDate = item.expirationDate else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let itemQuantity = Double(item.quantity)
        let weight = item.weight ?? "N/A"
        let unit = item.unit ?? "N/A"
        let category = item.catagory ?? "N/A"
        
        itemNameLabel.text = item.name
        expirationDateLabel.text = "Exp Date: \(dateFormatter.string(from: expirationDate))"
        stockedLabel.text = "Stocked: \(dateFormatter.string(from: stocked))"
        weightLabel.text = "Weight: \(weight) \(unit)"
        categoryLabel.text = "Category: \(category)"
        quantityLabel.text = "Quantity: \(itemQuantity)"
    }

    func setupQuantityStepper() {
        guard let item = item else {return}
        quantityStepper.stepValue = 1
        quantityStepper.value = Double(item.quantity)
        quantityStepper.maximumValue = 1000.0
        quantityStepper.isContinuous = false
        quantityStepper.autorepeat = false
        quantityStepper.addTarget(self, action: #selector(stepperTouched), for: .touchUpInside)
    }
    
    func setupLabelsProperties() {
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        expirationDateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        stockedLabel.font = UIFont.boldSystemFont(ofSize: 11)
        weightLabel.font = UIFont.boldSystemFont(ofSize: 11)
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 11)
        stockedLabel.textColor = Colors.mediumGray
        weightLabel.textColor = Colors.mediumGray
        categoryLabel.textColor = Colors.mediumGray
        itemNameLabel.numberOfLines = 3
        expirationDateLabel.textAlignment = .center
    }
    
    func setupAddToShoppingListButton() {
        addToShoppingListButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addToShoppingListButton.setImage(#imageLiteral(resourceName: "shoppingCartX2"), for: .normal)
        addToShoppingListButton.backgroundColor = Colors.yellow
        addToShoppingListButton.layer.cornerRadius = 0.5 * addToShoppingListButton.frame.size.width
        addToShoppingListButton.addTarget(self, action: #selector(beginHighlightButton), for: .touchDown)
        addToShoppingListButton.addTarget(self, action: #selector(addToListButtonPressed), for: .touchUpInside)
        addToShoppingListButton.addTarget(self, action: #selector(endHighlightButton), for: .touchUpOutside)
    }
    
    @objc func setupConstraints() {
        let height = frame.height * 1.25
        let width = frame.width * 0.4

        addConstraintsWithFormat(format: "V:|-5-[v0]-\(height)-|", views: itemNameLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]-\(width)-|", views: itemNameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(45)]-10-|", views: addToShoppingListButton)
        addConstraintsWithFormat(format: "H:|-10-[v0(45)]", views: addToShoppingListButton)
        
        addConstraintsWithFormat(format: "V:[v0]-5-|", views: expirationDateLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-[v1]-5-[v2]-5-[v3]-5-[v4]-5-|", views: stockedLabel, weightLabel, categoryLabel, quantityLabel, quantityStepper )
        expirationDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: stockedLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: weightLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: quantityLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: quantityStepper)
    }
}

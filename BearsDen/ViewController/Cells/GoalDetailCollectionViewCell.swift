//
//  GoalDetailCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

protocol GoalDetailCollectionViewCellDelegate: class {
    func switchTapped(cell: UICollectionViewCell, indexPath: Int, isSelected: Bool)
}

class GoalDetailCollectionViewCell: UICollectionViewCell, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var titleLabel = UILabel()
    let switchControl = UISwitch()

    //MARK: EXPANDED CELL ITEMS
    //NORMAL CELL
    let amountLabel = UILabel()
    let amountTextField = UITextField()
    let amountStack = UIStackView()
    
    let unitLabel = UILabel()
    let unitTextField = UITextField()
    let unitStack = UIStackView()
    
    let catagoryLabel = UILabel()
    let catagoryTextField = UITextField()
    let catagoryStack = UIStackView()
    
    let mainStack = UIStackView()
    //CUSTOM CELL
    
    let customTextLabel = UILabel()
    let customTextView = UITextView()
    let customStack = UIStackView()
    
    
    
    weak var delegate: GoalDetailCollectionViewCellDelegate?
    
    var isSwitchSelected = false
    var isCustom = false
    
    var item: GoalDetailItem? {
        didSet {
            updateViews()
        }
    }
    
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.veryLightGray
        addSubview(titleLabel)
        addSubview(switchControl)
        
        
        

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.2).isActive = true
        switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        

        switchControl.addTarget(self, action: #selector(switchTouched), for: .touchUpInside)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func updateViews() {
        guard let item = item else {return}
        titleLabel.text = item.name
        if item.isSelected {
            isSwitchSelected = true
            switchControl.isOn = true
        } else {
            isSwitchSelected = false
            switchControl.isOn = false
        }
    }
    
    func setupStackViews() {
        if isCustom == false {
            //STACK VIEWS
            addSubview(mainStack)
            mainStack.addArrangedSubview(amountStack)
            mainStack.addArrangedSubview(unitStack)
            mainStack.addArrangedSubview(catagoryStack)
            
            amountStack.addArrangedSubview(amountLabel)
            amountStack.addArrangedSubview(amountTextField)
            
            unitStack.addArrangedSubview(unitLabel)
            unitStack.addArrangedSubview(unitTextField)
            
            catagoryStack.addArrangedSubview(catagoryLabel)
            catagoryStack.addArrangedSubview(catagoryTextField)
            
            mainStack.axis = .vertical
            mainStack.distribution = .fillEqually
            mainStack.spacing = 2
            
            amountStack.axis = .horizontal
            amountStack.distribution = .fill
            amountStack.spacing = 2
            
            unitStack.axis = .horizontal
            unitStack.distribution = .fill
            unitStack.spacing = 2
            
            catagoryStack.axis = .horizontal
            catagoryStack.distribution = .fill
            catagoryStack.spacing = 2
            
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  frame.height * 0.15).isActive = true
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.05).isActive = true
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
            
            //PRORTIES IN STACK VIEWS
            
            amountLabel.text = "Amount"
            amountTextField.placeholder = "0.0"
            amountTextField.layer.borderWidth = 1
            amountTextField.layer.borderColor = Colors.softBlue.cgColor
            amountTextField.layer.cornerRadius = CornerRadius.textField
            amountTextField.backgroundColor = .white
            amountTextField.setLeftPaddingPoints(5)
            amountTextField.setRightPaddingPoints(5)
            amountTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6).isActive = true
            amountTextField.delegate = self
            amountTextField.returnKeyType = .done
            
            unitLabel.text = "Unit"
            unitTextField.placeholder = "0.0"
            unitTextField.layer.borderWidth = 1
            unitTextField.layer.borderColor = Colors.softBlue.cgColor
            unitTextField.layer.cornerRadius = CornerRadius.textField
            unitTextField.backgroundColor = .white
            unitTextField.setLeftPaddingPoints(5)
            unitTextField.setRightPaddingPoints(5)
            unitTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6).isActive = true
            
            catagoryLabel.text = "Catagory"
            catagoryTextField.placeholder = "0.0"
            catagoryTextField.layer.borderWidth = 1
            catagoryTextField.layer.borderColor = Colors.softBlue.cgColor
            catagoryTextField.layer.cornerRadius = CornerRadius.textField
            catagoryTextField.backgroundColor = .white
            catagoryTextField.setLeftPaddingPoints(5)
            catagoryTextField.setRightPaddingPoints(5)
            catagoryTextField.widthAnchor.constraint(equalToConstant: self.frame.width * 0.6).isActive = true
        } else {
            
            addSubview(customStack)
            customStack.addArrangedSubview(customTextLabel)
            customStack.addArrangedSubview(customTextView)
            customStack.axis = .vertical
            customStack.distribution = .fill
            customStack.spacing = 2
            
            customTextLabel.text = "Custom Goal Description"
            customTextView.text = ""
            customTextView.layer.borderWidth = 1
            customTextView.layer.cornerRadius = CornerRadius.textField
            customTextView.delegate = self
            customTextView.returnKeyType = .done
            customTextView.layer.borderColor = Colors.softBlue.cgColor
            customTextView.heightAnchor.constraint(equalToConstant: frame.height * 0.5).isActive = true
            customTextView.backgroundColor = .white
            
            customStack.translatesAutoresizingMaskIntoConstraints = false
            customStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  frame.height * 0.1).isActive = true
            customStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.05).isActive = true
            customStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            customStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    @objc func switchTouched() {
        guard let localIndexPath = indexPath?.row
        else {return}
        if isSwitchSelected {
            delegate?.switchTapped(cell: self, indexPath: localIndexPath, isSelected: false)
            isSwitchSelected = false
            hideItems()
        } else {
            delegate?.switchTapped(cell: self, indexPath: localIndexPath, isSelected: true)
            isSwitchSelected = true
            showItems()
        }
    }
    
    func showItems() {
        setupStackViews()
    }
    
    func hideItems() {
        if isCustom {
            customStack.removeFromSuperview()
        } else {
            mainStack.removeFromSuperview()
        }
    }
}

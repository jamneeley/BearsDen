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

    //MARK: - Properties
    
    var titleLabel = UILabel()
    let switchControl = UISwitch()

    //MARK: EXPANDED CELL ITEMS
    
    //Normal cell
    let amountLabel = UILabel()
    let amountTextField = UITextField()
    let amountStack = UIStackView()
    let unitLabel = UILabel()
    let unitPicker = UIPickerView()
    let unitPickerView = UIView()
    let unitStack = UIStackView()
    let mainStack = UIStackView()
    
    //Custom cell
    let customTextLabel = UILabel()
    let customTextView = UITextView()
    let customStack = UIStackView()

    
    // Settable Properties
    var isSwitchSelected = false
    var isCustom = false
    
    var customDescription = ""
    var amountText = ""
    var unit = ""
    var catagory = ""

    weak var delegate: GoalDetailCollectionViewCellDelegate?
    
    var item: String? {
        didSet {
            updateNonCustomViewsWithItem()
        }
    }
    var goalItem: GoalItem? {
        didSet {
            let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(coordinateViewWithGoalItem), userInfo: nil, repeats: false)
        }
    }

    var indexPath: IndexPath?
    var rotationAngle: CGFloat = -90 * (.pi/180)
    
    //MARK: - Cell initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    
    //MARK: - PickerView DataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == unitPicker {
            return PickerViewProperties.units.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.textAlignment = .center
        if pickerView == unitPicker {
            label.text = PickerViewProperties.units[row]
        } else {
            print("picker view out of range")
        }
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: -rotationAngle)
        return view
    }

    //Mark: - DidFinishEditing Expandable cell views
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == unitPicker {
            let pickerViewIndex = pickerView.selectedRow(inComponent: 0)
            let value = PickerViewProperties.units[pickerViewIndex]
            unit = value
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            customDescription = text
        }
    }
    
    @objc func textFieldChanged() {
        if let text = amountTextField.text {
            amountText = text
        }
    }
    
    //MARK: - TextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            endEditing(true)
        }
        return true
    }
    
    //Custom Methods
    
    func findIndexOf(Unit: String) -> Int {
        for item in PickerViewProperties.units {
            if Unit == item {
                guard let index = PickerViewProperties.units.index(of: item) else {print("index doesnt exist for catagory"); return 0}
                print(index)
                return index
            }
        }
        print("Not unit or catagory")
        return 0
    }
    
    
    @objc func changeFrameOfPickers() {
        unitPicker.frame = CGRect(x: 0, y: 0, width: unitPickerView.frame.width, height: unitPickerView.frame.height)
        guard let item = item else {return}
        print("should update picker position for \(item)")
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
            setupStackViews()
        }
    }
    
    func hideItems() {
        if isCustom {
            customStack.removeFromSuperview()
        } else {
            mainStack.removeFromSuperview()
        }
    }
    

////////////////////////
    //MARK: - VIEWS
///////////////////////
    
    
    func setupViews() {
        self.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(switchControl)

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        //Title Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        //SwitchControl Constraints
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.2).isActive = true
        switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        switchControl.addTarget(self, action: #selector(switchTouched), for: .valueChanged)
    }
    
    func updateNonCustomViewsWithItem() {
        guard let item = item else {return}
        titleLabel.text = item
        catagory = item
        unit = "lb."
    }
    
    @objc func coordinateViewWithGoalItem() {
        guard let goalItem = goalItem else {return}
        if goalItem.isCustom {
            isCustom = true
            if let customText = goalItem.customText {
                self.customDescription = customText
                switchControl.isOn = true
            }
        } else {
            if let text = goalItem.amount {
                self.amountText = text
                if let unitText = goalItem.unit {
                    unit = unitText
                    switchControl.isOn = true
                }
            }
        }
        switchTouched()
    }
    
    func setupStackViews() {
        //setupNon Expansion
        if isCustom == false {
            addSubview(mainStack)
            mainStack.addArrangedSubview(amountStack)
            mainStack.addArrangedSubview(unitStack)
            amountStack.addArrangedSubview(amountLabel)
            amountStack.addArrangedSubview(amountTextField)
            unitStack.addArrangedSubview(unitLabel)
            unitStack.addArrangedSubview(unitPickerView)
            unitPickerView.addSubview(unitPicker)
            
            setup(StackView: mainStack)
            setup(StackView: amountStack)
            setup(StackView: unitStack)
            
            setupAmountTextField()
            setupNonCustomConstraints()
            setupPickerViews()
            
            unitLabel.text = "Units"
            unitLabel.textAlignment = .left
        //setup Custom Expansion
        } else {
            addSubview(customStack)
            customStack.addArrangedSubview(customTextLabel)
            customStack.addArrangedSubview(customTextView)
            setup(StackView: customStack)
            setupCustomTextView()
            guard let goalItem = goalItem else {return}
            customTextView.text = goalItem.customText
        }
    }
    
    func setup(StackView stackView: UIStackView) {
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.axis = .vertical
    }
    
    //MARK: - Non Custom Setup
    func setupAmountTextField() {
        amountLabel.text = "Amount"
        amountTextField.placeholder = "0.0"
        amountTextField.layer.borderWidth = 1
        amountTextField.layer.borderColor = Colors.softBlue.cgColor
        amountTextField.layer.cornerRadius = CornerRadius.textField
        amountTextField.keyboardType = .decimalPad
        amountTextField.returnKeyType = .done
        amountTextField.autocorrectionType = UITextAutocorrectionType.no
        amountTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        amountTextField.backgroundColor = .white
        amountTextField.setLeftPaddingPoints(5)
        amountTextField.setRightPaddingPoints(5)
        amountTextField.delegate = self
        amountTextField.returnKeyType = .done

        amountTextField.addDoneButtonToKeyboard(myAction: #selector(self.amountTextField.resignFirstResponder))
    }
    
    func setupPickerViews() {
        unitPickerView.backgroundColor = .white
        unitPickerView.layer.borderWidth = 1
        unitPickerView.layer.borderColor = Colors.softBlue.cgColor
        unitPickerView.layer.cornerRadius = CornerRadius.textField
        unitPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        unitPicker.delegate = self
        unitPicker.dataSource = self
        let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeFrameOfPickers), userInfo: nil, repeats: false)
        guard let goalItem = goalItem,
            let goalUnit = goalItem.unit
            else {return}
        let index = findIndexOf(Unit: goalUnit)
        
        unitPicker.selectRow(index, inComponent: 0, animated: false)
        amountTextField.text = goalItem.amount ?? ""
    }
    
    func setupNonCustomConstraints() {
        amountTextField.heightAnchor.constraint(equalToConstant: frame.height * 0.2).isActive = true
        amountStack.heightAnchor.constraint(equalToConstant: frame.height * 0.3).isActive = true
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  frame.height * 0.1).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.05).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    //MARK: - Custom Setup
    
    func setupCustomTextView() {
        customTextLabel.text = "Custom Goal Description"
        customTextView.text = ""
        customTextView.layer.borderWidth = 1
        customTextView.layer.cornerRadius = CornerRadius.textField
        customTextView.delegate = self
        customTextView.returnKeyType = .done
        customTextView.autocorrectionType = UITextAutocorrectionType.no
        customTextView.layer.borderColor = Colors.softBlue.cgColor
        customTextView.heightAnchor.constraint(equalToConstant: frame.height * 0.5).isActive = true
        customTextView.backgroundColor = .white
        setupCustomConstraints()
    }
    
    func setupCustomConstraints() {
        customStack.translatesAutoresizingMaskIntoConstraints = false
        customStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  frame.height * 0.1).isActive = true
        customStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.05).isActive = true
        customStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        customStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

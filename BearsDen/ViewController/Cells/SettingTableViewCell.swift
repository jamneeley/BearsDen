//
//  SettingTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/5/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
protocol SettingCellDelegate: class {
    func settingActionTaken(settingNumber: Int)
}

class SettingTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    var object: UIView?
    weak var delegate: SettingCellDelegate?
    
    
    //bug when coming back to cell when the settingtableview has already loaded once
    
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {return}
        UserController.shared.updateUser(houseHoldName: text)
        print("saved")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return endEditing(true)
    }
    
    func updateViews() {
        guard let setting = setting else {return}
        titleLabel.text = setting.title
        object = setting.object
        guard let object = object else {return}
        addSubview(titleLabel)
        addSubview(object)
        
        if setting.settingVariable != "" {
            addSubview(numberLabel)
            numberLabel.text = "\(setting.settingVariable)"
            addConstraintsWithFormat(format: "H:|-15-[v0]-20-[v1]", views: titleLabel, numberLabel)
            addConstraintsWithFormat(format: "V:|-10-[v0]", views: titleLabel)
            addConstraintsWithFormat(format: "V:|-10-[v0]", views: numberLabel)
            addConstraintsWithFormat(format: "V:|-20-[v0]", views: object)
        } else {
            addConstraintsWithFormat(format: "H:|-15-[v0]", views: titleLabel)
            addConstraintsWithFormat(format: "V:|-10-[v0]", views: titleLabel)
            addConstraintsWithFormat(format: "H:[v0]-15-|", views: object)
            addConstraintsWithFormat(format: "V:|-10-[v0]", views: object)
        }
        setupObjects(setting: setting)
    }
    
    func setupObjects(setting: Setting) {
        switch setting.number {
        case 1:
            if let textField = object as? UITextField {
                textField.addTarget(self, action: #selector(saveDenName), for: .editingDidEnd)
                textField.text = UserController.shared.user?.houseHoldName
                textField.delegate = self
                textField.isUserInteractionEnabled = true
                textField.textAlignment = .right
                textField.returnKeyType = .done
                textField.autocorrectionType = UITextAutocorrectionType.no
                textField.setRightPaddingPoints(10)
                textField.setLeftPaddingPoints(10)
                textField.layer.borderWidth = 2
                textField.layer.borderColor = Colors.softBlue.cgColor
                textField.layer.cornerRadius = 12
                addConstraintsWithFormat(format: "H:[v0(\(self.frame.width * 0.6))]", views: textField)
                addConstraintsWithFormat(format: "V:[v0(\(self.frame.height * 0.75))]", views: textField)
            }
        case 2:
            if let stepper = object as? UIStepper {
                let adultsString = UserController.shared.user?.adults ?? "0"
                if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: adultsString)){
                    let adults = Double(adultsString)!
                    stepper.stepValue = 1
                    stepper.value = adults
                    stepper.autorepeat = false
                    stepper.isContinuous = false
                    stepper.addTarget(self, action: #selector(adultsStepperTouched), for: .touchUpInside)
                    addConstraintsWithFormat(format: "H:[v0]-10-|", views: stepper)
                }
            }
        case 3:
            if let stepper = object as? UIStepper {
                let kidsString = UserController.shared.user?.kids ?? "0"
                if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: kidsString)){
                    let kids = Double(kidsString)!
                    stepper.stepValue = 1
                    stepper.value = kids
                    stepper.autorepeat = false
                    stepper.isContinuous = false
                    stepper.addTarget(self, action: #selector(kidsStepperTouched), for: .touchUpInside)
                    addConstraintsWithFormat(format: "H:[v0]-10-|", views: stepper)                }
            }
        case 4:
            if let button = object as? UIButton {
                button.setTitle("Show", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                button.isUserInteractionEnabled = true
                button.backgroundColor = Colors.green
                button.layer.cornerRadius = 12
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                addConstraintsWithFormat(format: "H:[v0(\(self.frame.width * 0.18))]", views: button)
                addConstraintsWithFormat(format: "V:[v0(\(self.frame.height * 0.75))]", views: button)
            }
        case 5:
            if let label = object as? UILabel {
                label.text = "bearsdenfoodstorage@Gmail.com"
                label.font = UIFont.boldSystemFont(ofSize: 13)
                label.textAlignment = .right
                addConstraintsWithFormat(format: "H:[v0(\(self.frame.width * 0.8))]", views: label)
                addConstraintsWithFormat(format: "V:[v0(\(self.frame.height * 0.75))]", views: label)
            }
        case 6:
            if let button = object as? UIButton {
                button.setTitle("Donate", for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                button.setTitleColor(.black, for: .normal)
                button.isUserInteractionEnabled = true
                button.backgroundColor = Colors.green
                button.layer.cornerRadius = 12
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                addConstraintsWithFormat(format: "H:[v0(\(self.frame.width * 0.18))]", views: button)
                addConstraintsWithFormat(format: "V:[v0(\(self.frame.height * 0.75))]", views: button)
            }
        case 7:
            if let button = object as? UIButton {
                button.setTitle("Rate Us", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                button.isUserInteractionEnabled = true
                button.backgroundColor = Colors.green
                button.layer.cornerRadius = 12
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                addConstraintsWithFormat(format: "H:[v0(\(self.frame.width * 0.18))]", views: button)
                addConstraintsWithFormat(format: "V:[v0(\(self.frame.height * 0.75))]", views: button)
            }
        default:
            print("something went wrong with the setupObject in settingTableViewCell")
        }
    }
    @objc func saveDenName() {
        if let textField = object as? UITextField {
            guard let text = textField.text, !text.isEmpty else {return}
            UserController.shared.updateUser(houseHoldName: text)
        }
    }
    
    
    @objc func adultsStepperTouched() {
        if let stepper = object as? UIStepper {
            numberLabel.text = "\(Int(stepper.value))"
            UserController.shared.change(Adult: "\(Int(stepper.value))")
        }
    }
    
    @objc func kidsStepperTouched() {
        if let stepper = object as? UIStepper {
            numberLabel.text = "\(Int(stepper.value))"
            UserController.shared.change(Kids: "\(Int(stepper.value))")
        }
    }
    
    @objc func buttonPressed() {
        guard let setting = setting else {return}
        switch setting.number {
        case 1:
            buttonPressedFor(Setting: 1)
        case 2:
            buttonPressedFor(Setting: 2)
        case 3:
            buttonPressedFor(Setting: 3)
        case 4:
            buttonPressedFor(Setting: 4)
        case 5:
            buttonPressedFor(Setting: 5)
        case 6:
            buttonPressedFor(Setting: 6)
        case 7:
            buttonPressedFor(Setting: 7)
        default:
            print("button pressed setting out of range")
        }
    }
    
    func buttonPressedFor(Setting: Int) {
        delegate?.settingActionTaken(settingNumber: Setting)
    }
}

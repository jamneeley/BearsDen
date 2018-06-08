//
//  AddBarcodeViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/10/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class AddBarcodeViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    //TOPSTACK WITHIN MAIN STACK
    let upperStack = UIStackView()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStack = UIStackView()
    
    let quantityLabel = UILabel()
    let quantityTextField = UITextField()
    let quantityStack = UIStackView()
    
    let weightLabel = UILabel()
    let weightTextField = UITextField()
    let weightStack = UIStackView()
    
    //bottom stack within main
    let lowerStack = UIStackView()
    let unitLabel = UILabel()
    let unitPicker = UIPickerView()
    let unitPickerView = UIView()
    let unitStack = UIStackView()
    
    let catagoryLabel = UILabel()
    let catagoryPicker = UIPickerView()
    let catagoryPickerView = UIView()
    let catagoryStack = UIStackView()
    
    let entryStack = UIStackView()
    
    //BOTTOM STACK
    let barcodeLabel = UILabel()
    let barcodeTextField = UITextField()
    let barCodeStack = UIStackView()
    
    let dateLabel = UILabel()
    let datePicker = UIDatePicker()

    let tapView = UIView()
    let singleTap = UITapGestureRecognizer()
    
    var shelf: Shelf?
    let arbitraryButton = UIButton(type: .custom)
    
    var cloudItem: CloudItem? {
        didSet {
            updateViews()
        }
    }
    
    var rotationAngle: CGFloat = -90 * (.pi/180)
    var viewControllerToPopTo: UIViewController?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        unitPicker.frame = CGRect(x: 0, y: 0, width: unitPickerView.frame.width, height: unitPickerView.frame.height)
        catagoryPicker.frame = CGRect(x: 0, y: 0, width: catagoryPickerView.frame.width, height: catagoryPickerView.frame.height)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(callViewDidLayoutSubviews), userInfo: nil, repeats: false)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .done, target: self, action: #selector(backButtonPressed))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    
    //JERRY RIGGED!
    
    @objc func callViewDidLayoutSubviews() {
        viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    func updateViews() {
        guard let cloudItem = cloudItem else {return}
        nameTextField.text =  cloudItem.name
        barcodeTextField.text = cloudItem.barcode
        weightTextField.text = cloudItem.weight
        let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePickerPosition), userInfo: nil, repeats: false)
        
    }
    
    @objc func updatePickerPosition() {
        guard let cloudItem = cloudItem else {return}
        let unitIndex = findIndexOf(Unit: cloudItem.unit, catagory: "")
        let catagoryIndex = findIndexOf(Unit: "", catagory: cloudItem.catagory)
        catagoryPicker.selectRow(catagoryIndex, inComponent: 0, animated: false)
        unitPicker.selectRow(unitIndex, inComponent: 0, animated: false)
    }

    
    func findIndexOf(Unit: String, catagory: String) -> Int {
        if Unit != "" {
            for item in PickerViewProperties.units {
                if Unit == item {
                    guard let index = PickerViewProperties.units.index(of: item) else {print("index doesnt exist for catagory"); return 0}
                    print(index)
                    return index
                }
            }
        } else {
            for item in PickerViewProperties.catagories {
                if catagory == item {
                    guard let index = PickerViewProperties.catagories.index(of: item) else {print("index doesnt exist for catagory"); return 0}
                    print(index)
                    return index
                }
            }
        }
        print("Not unit or catagory")
        return 0
    }
    
    func setupObjects() {
        setupDatePicker()
        setupDateLabel()
        setupBarcodeStack()
        setupBarcodeLabel()
        setupBarCodeTextField()
        setupSingleTap()
        
        
        setupAllUpperStackViews()
        setupNameObjects()
        setupQuantityObjects()
        setupWeightObjects()
        setupUnitObjects()
        setupCatagoryObjects()
        setupButton()
    }
    
    func setupButton() {
        view.addSubview(arbitraryButton)
        arbitraryButton.frame = CGRect(x: -view.frame.width, y: -view.frame.height, width: 40, height: 40)
        arbitraryButton.setImage(#imageLiteral(resourceName: "BackLargeX1"), for: .normal)
        arbitraryButton.setTitleColor(.white, for: .normal)
        arbitraryButton.backgroundColor = Colors.green
        arbitraryButton.layer.cornerRadius = 0.5 * arbitraryButton.bounds.size.width
        arbitraryButton.clipsToBounds = true
    }
    
    @objc func backButtonPressed() {
        if let viewToPopTo = viewControllerToPopTo {
            navigationController?.popToViewController(viewToPopTo, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func keyBoardWillShow() {
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func disableKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide() {
        view.removeGestureRecognizer(singleTap)
    }
    
    @objc func saveButtonPressed() {
        guard let name = nameTextField.text,
        let quantityAsString = quantityTextField.text,
        let shelf = self.shelf,
        let weight = weightTextField.text
        else {return}
        let date = datePicker.date
        let unitIndex = unitPicker.selectedRow(inComponent: 0)
        let catagoryIndex = catagoryPicker.selectedRow(inComponent: 0)
        let unit = PickerViewProperties.units[unitIndex]
        let catagory = PickerViewProperties.catagories[catagoryIndex]
        
        //is there a quantity and weight and are they both numbers?
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: quantityAsString)) &&  CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: weight)) && quantityAsString != "" && name != "" && weight != ""{
            let barcodeNumber = barcodeTextField.text
            let quantity = Double(quantityAsString)
            //does cloudItem, barcode number exist?
            if let cloudItem = self.cloudItem, barcodeNumber != "" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: barcodeNumber!)) {
                
                ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, weight: weight, unit: unit, catagory: catagory, barcode: barcodeNumber!, shelf: shelf)
                
                    barcodeTextField.text = ""
                CloudItemController.shared.update(cloudItem: cloudItem, name: name, weight: weight, catagory: catagory, unit: unit) { (success) in
                    if success {
                        //success updating cloud
                        DispatchQueue.main.async {
                            self.presentSaveAnimation()
                            self.view.isUserInteractionEnabled = true
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                            self.weightTextField.text = ""
                            print("ITEM EXISTS AND WAS UPDATED")
                        }
                        //saved to phone because update was unsuccessful
                    } else {
                        DispatchQueue.main.async {
                            self.presentSaveAnimation()
                            self.view.isUserInteractionEnabled = true
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                            self.weightTextField.text = ""
                            print("ITEM EXISTS AND WAS NOT UPDATED")
                        }
                    }
                }
            //NO BARCODE AND WAS SAVED LOCALLY BUT NOT ON THE CLOUD
            } else {
                print("NO BARCODE AND WAS SAVED LOCALLY BUT NOT ON THE CLOUD")
                ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, weight: weight, unit: unit, catagory: catagory, barcode: "", shelf: shelf)
                presentSaveAnimation()
            }
            if let viewToPopTo = viewControllerToPopTo {
                self.navigationController?.popToViewController(viewToPopTo, animated: true)
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        //quantity doesnt exist or its not a number
        } else {
            presentSaveAlert(WithTitle: "Uh Oh", message: "You need an item name, quantity and weight")
        }
    }
    
    func presentSaveAlert(WithTitle title: String, message: String) {
        var alert = UIAlertController()
        if message == "" {
            alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        }
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == unitPicker {
            return PickerViewProperties.units.count
        } else if pickerView == catagoryPicker {
            return PickerViewProperties.catagories.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.textAlignment = .center
        if pickerView == unitPicker {
            label.text = PickerViewProperties.units[row]
        } else if pickerView == catagoryPicker{
            label.text = PickerViewProperties.catagories[row]
        } else {
            print("picker view out of range")
        }
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: -rotationAngle)
        return view
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension AddBarcodeViewController {
    
    ///////////////
    //UPPER STACK
    ///////////////
    
    func setupAllUpperStackViews() {
        //main stack
        view.addSubview(entryStack)
        //upper lower stack within mainstack
        entryStack.addArrangedSubview(upperStack)
        entryStack.addArrangedSubview(lowerStack)
        //all stacks within upper lower stack
        upperStack.addArrangedSubview(nameStack)
        upperStack.addArrangedSubview(quantityStack)
        upperStack.addArrangedSubview(weightStack)
        
        lowerStack.addArrangedSubview(unitStack)
        lowerStack.addArrangedSubview(catagoryStack)
        
        //views within those stacks ^
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameTextField)
        quantityStack.addArrangedSubview(quantityLabel)
        quantityStack.addArrangedSubview(quantityTextField)
        weightStack.addArrangedSubview(weightLabel)
        weightStack.addArrangedSubview(weightTextField)
        
        unitStack.addArrangedSubview(unitLabel)
        unitStack.addArrangedSubview(unitPickerView)
        unitPickerView.addSubview(unitPicker)
        
        catagoryStack.addArrangedSubview(catagoryLabel)
        catagoryStack.addArrangedSubview(catagoryPickerView)
        catagoryPickerView.addSubview(catagoryPicker)
        
        
        
        //Properties for all stacks
        //Main Stack properties
        entryStack.axis = .vertical
        entryStack.spacing = 10
        entryStack.distribution = .fillEqually
        
        upperStack.axis = .vertical
        upperStack.spacing = 10
        upperStack.distribution = .fillEqually
        
        lowerStack.axis = .vertical
        lowerStack.spacing = 5
        lowerStack.distribution = .fillEqually
        
        //Name Stack properties
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        nameStack.distribution = .fill
        nameStack.axis = .horizontal
        nameStack.spacing = 5
        
        //Quantity Stack properties
        quantityTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        quantityStack.distribution = .fill
        quantityStack.axis = .horizontal
        quantityStack.spacing = 5
        
        //Weight Stack properties
        weightTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        weightStack.distribution = .fill
        weightStack.axis = .horizontal
        weightStack.spacing = 5
        
        //Unit stack properties
        unitPickerView.layer.borderWidth = 1
        unitPickerView.layer.borderColor = Colors.softBlue.cgColor
        unitPickerView.layer.cornerRadius = CornerRadius.textField
        
        
        unitStack.distribution = .fill
        unitStack.spacing = 5
        unitStack.axis = .vertical
        
        //Catagory Stack Properties
        catagoryPickerView.layer.borderWidth = 1
        catagoryPickerView.layer.borderColor = Colors.softBlue.cgColor
        catagoryPickerView.layer.cornerRadius = CornerRadius.textField
        
        
        catagoryStack.distribution = .fill
        catagoryStack.spacing = 5
        catagoryStack.axis = .vertical
        
    
        setupStackViewConstraints()
    }
    
    func setupSingleTap() {
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(disableKeyBoard))
    }
    
    
    func setupNameLabel() {
        nameLabel.text = "Name"
        nameLabel.textAlignment = .left
        nameLabel.tintColor = .white
    }
    
    func setupNameObjects() {
        nameTextField.setLeftPaddingPoints(5)
        nameTextField.placeholder = "Brand + Item Name"
        nameTextField.layer.cornerRadius = 12
        nameTextField.backgroundColor = .white
        nameTextField.returnKeyType = .done
        self.nameTextField.delegate = self;
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = Colors.softBlue.cgColor
        nameTextField.autocorrectionType = .no
        nameLabel.text = "Name"
        nameLabel.textAlignment = .left
    }
    
    func setupQuantityObjects() {
        quantityTextField.setLeftPaddingPoints(5)
        quantityTextField.layer.cornerRadius = 12
        quantityTextField.backgroundColor = .white
        quantityTextField.keyboardType = .numberPad
        quantityTextField.text = "\(1)"
        quantityTextField.returnKeyType = .done
        self.quantityTextField.delegate = self
        quantityTextField.layer.borderWidth = 1
        quantityTextField.layer.borderColor = Colors.softBlue.cgColor
        quantityTextField.autocorrectionType = .no
        quantityLabel.text = "Quantity"
        quantityLabel.textAlignment = .left
    }
    
    func setupWeightObjects() {
        weightLabel.text = "Weight"
        weightLabel.textAlignment = .left
        weightTextField.placeholder = "0"
        weightTextField.layer.cornerRadius = 12
        weightTextField.setLeftPaddingPoints(5)
        weightTextField.backgroundColor = .white
        weightTextField.keyboardType = .numberPad
        self.nameTextField.delegate = self;
        weightTextField.layer.borderWidth = 1
        weightTextField.layer.borderColor = Colors.softBlue.cgColor
        weightTextField.autocorrectionType = .no
    }
    
    func setupUnitObjects() {
        unitLabel.text = "Unit"
        unitLabel.textAlignment = .left
        unitPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        unitPicker.delegate = self
        unitPicker.dataSource = self
    }
    func setupCatagoryObjects() {
        catagoryLabel.text = "Catagory"
        catagoryLabel.textAlignment = .left
        catagoryPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        catagoryPicker.delegate = self
        catagoryPicker.dataSource = self
    }
    
    func setupStackViewConstraints() {
        entryStack.translatesAutoresizingMaskIntoConstraints = false
        entryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.02).isActive = true
        entryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        entryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        entryStack.bottomAnchor.constraint(equalTo: barCodeStack.topAnchor, constant: -10).isActive = true
    }
    
    //////////////////////
    //BOTTOM STACK
    //////////////////////
    
    func setupBarcodeStack() {
        view.addSubview(barCodeStack)
        barCodeStack.addArrangedSubview(barcodeLabel)
        barCodeStack.addArrangedSubview(barcodeTextField)
        barCodeStack.spacing = 2
        barCodeStack.axis = .vertical
        barCodeStack.distribution = .fillProportionally
        setupBarcodeStackConstraints()
    }

    func setupBarcodeLabel() {
        barcodeLabel.text = "Barcode Number"
        barcodeLabel.textAlignment = .center
        barcodeLabel.tintColor = .white
    }
    
    func setupBarCodeTextField() {
        barcodeTextField.setLeftPaddingPoints(5)
        barcodeTextField.backgroundColor = .white
        barcodeTextField.isUserInteractionEnabled = false
        barcodeTextField.placeholder = "Use Barcode Scanner ->"
        barcodeTextField.layer.cornerRadius = 12
        barcodeTextField.layer.borderWidth = 1
        barcodeTextField.layer.borderColor = Colors.softBlue.cgColor
    }
    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.text = "Expiration Date"
        dateLabel.textAlignment = .center
        setupDateLabelConstraints()
    }
    
    func setupDatePicker() {
        view.addSubview(datePicker)
        datePicker.datePickerMode = .date
        let monthsToAdd = 6
        guard let newDate = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: Date()) else {return}
        datePicker.date = newDate
        datePicker.layer.cornerRadius = 12
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = Colors.softBlue.cgColor
        print(newDate)
        setupDatePickerConstraints()
    }
    
    func setupBarcodeStackConstraints() {
        barCodeStack.translatesAutoresizingMaskIntoConstraints = false
        barCodeStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.1).isActive = true
        barCodeStack.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: view.frame.height * -0.02).isActive = true
        barCodeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        barCodeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
    }
    
    func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: -32).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -12).isActive = true
    }
    
    func setupDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints =  false
        datePicker.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.3).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height * -0.05).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
    }
}



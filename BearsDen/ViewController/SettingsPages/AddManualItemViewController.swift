//
//  AddManualItemViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class AddManualItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //topStack
    //Top stack within main stack
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
    
    
    //BottomStack
    let barcodeLabel = UILabel()
    let barcodeTextField = UITextField()
    let dateLabel = UILabel()
    let datePicker = UIDatePicker()
    let barCodeStack = UIStackView()
    
    //Buttons
    let saveButton = UIButton(type: .custom)
    let barcodeButton = UIButton(type: .custom)
    let clearButton = UIButton(type: .custom)
    
    //other properties
    var shelf: Shelf?
    let tapView = UIView()
    let singleTap = UITapGestureRecognizer()
    
    var inDataBase: Bool?
    var itemExists: Bool?
    var cloudItem : CloudItem?
    
    var barcode: String? {
        didSet {
            barcodeTextField.text = barcode
        }
    }
    var rotationAngle: CGFloat = -90 * (.pi/180)
    var viewControllerToPopTo: UIViewController?
    
    func doesItemExist() {
        guard let itemExist = itemExists else {return}
        if itemExist {
            print("item exists?")
            return
        } else {
            presentSaveAlert(WithTitle: "Sorry, that item isnt in our database", message: "Save the item with a barcode and next time it will :)")
            itemExists = nil
        }
    }
    
    override func viewDidLayoutSubviews() {
        unitPicker.frame = CGRect(x: 0, y: 0, width: unitPickerView.frame.width, height: unitPickerView.frame.height)
        catagoryPicker.frame = CGRect(x: 0, y: 0, width: catagoryPickerView.frame.width, height: catagoryPickerView.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        doesItemExist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupObjects()
    }
    
    func setupObjects() {
        //bottom stack
        setupSaveButton()
        setupDatePicker()
        setupDateLabel()
        setupBarCodeButton()
        setupClearButton()
        setupBarcodeStack()
        setupBarcodeLabel()
        setupBarCodeTextField()
        setupSingleTap()
        
        //top stack
        setupAllStackProperties()
        setupNameObjects()
        setupQuantityObjects()
        setupWeightObjects()
        setupUnitObjects()
        setupCatagoryObjects()
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

    @objc func startHighlightclear() {
        clearButton.layer.backgroundColor = Colors.softBlue.cgColor
        clearButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func stopHighlightclear() {
        clearButton.layer.backgroundColor = Colors.green.cgColor
        clearButton.setTitleColor(.black, for: .normal)
    }

    @objc func startHighlightBarCode() {
        barcodeButton.layer.backgroundColor = Colors.softBlue.cgColor
        barcodeButton.imageView?.tintColor = .white
    }
    
    @objc func stopHighlightBarCode() {
        barcodeButton.layer.backgroundColor = Colors.green.cgColor
        barcodeButton.imageView?.tintColor = nil
    }
    
    @objc func startHighlightSave() {
        saveButton.layer.backgroundColor = Colors.softBlue.cgColor
        saveButton.imageView?.tintColor = .white
    }
    
    @objc func stopHighlightSave() {
        saveButton.layer.backgroundColor = Colors.green.cgColor
        saveButton.imageView?.tintColor = nil
    }
    
    @objc func clearButtonPressed() {
        stopHighlightclear()
        barcodeTextField.text = ""
    }
    
    @objc func barcodeButtonPressed() {
        print("bar code button pressed")
        stopHighlightBarCode()
        let scannerViewController = BarcodeScannerViewController()
        scannerViewController.codeDelegate = self
        scannerViewController.errorDelegate = self
        scannerViewController.dismissalDelegate = self
        navigationController?.pushViewController(scannerViewController, animated: true)
    }
    
    
    
    @objc func saveButtonPressed() {
    self.view.isUserInteractionEnabled = false
        stopHighlightSave()
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
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: quantityAsString)) &&  CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: weight))  && quantityAsString != "" && name != "" && weight != "" {
            
            let barcodeNumber = barcodeTextField.text
            let quantity = Double(quantityAsString)
            
            //is there a barcode and is it a number?
            if barcodeNumber != "" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: barcodeNumber!)){
                //does this barcode already exist in the DB?
                if cloudItem != nil && inDataBase == true {
                    CloudItemController.shared.update(cloudItem: self.cloudItem!, name: name, weight: weight, catagory: catagory, unit: unit) { (success) in
                        //reset the clouditem
                        self.cloudItem = nil
                        self.inDataBase = nil
                        print("ITEM SAVED WITH BARCODE AND CLOUD ITEM UPDATED")
                        ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, weight: weight, unit: unit, catagory: catagory, barcode: barcodeNumber!, shelf: shelf)
                        DispatchQueue.main.async {
                            self.saveAnimation()
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                            self.weightTextField.text = ""
                        }
                    }
                // barcode doesnt exists in the database
                } else {
                    CloudItemController.shared.createCloudItem(withName: name, weight: weight, catagory: catagory, unit: unit, barcode: barcodeNumber!) { (success) in
                        //reset the clouditem
                        self.cloudItem = nil
                        self.inDataBase = nil
                        print("ITEM SAVED WITH BARCODE AND CLOUD ITEM SAVED")
                        ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, weight: weight, unit: unit, catagory: catagory, barcode: barcodeNumber!, shelf: shelf)
                        DispatchQueue.main.async {
                            self.saveAnimation()
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                            self.weightTextField.text = ""
                        }
                    }
                }
            //there isnt a barcode number or it isnt a number
            } else {
                print("ITEM SAVED LOCALLY WITHOUT BARCODE")
                ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, weight: weight, unit: unit, catagory: catagory, barcode: "", shelf: shelf)
                saveAnimation()
                nameTextField.text = ""
                barcodeTextField.text = ""
                weightTextField.text = ""
            }
        //itemName and quantity doesnt exist or quantity isnt a number
        } else {
            presentSaveAlert(WithTitle: "Uh Oh", message: "You need an item name, quantity and weight")
        }
        self.view.isUserInteractionEnabled = true
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
    
    func saveAnimation() {
        let brightView = UIView()
        brightView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(brightView)
        brightView.backgroundColor = Colors.clear
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
            brightView.backgroundColor = Colors.white
        }) { (success) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                brightView.backgroundColor = Colors.clear
                brightView.removeFromSuperview()
            }, completion: { (success) in
            })
        }
    }
    
    //MARK: - UIPICKER DATA SOURCE
    
    
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

//MARK: - BARCODE SCANNER METHODS

extension AddManualItemViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        barcodeScanner(controller, didCaptureCode: code, type: type)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        CloudItemController.shared.fetchCloudItem(WithBarcode: code) { (cloudItem) in
            if let localClouditem = cloudItem {
                DispatchQueue.main.async {
                    self.inDataBase = true
                    self.cloudItem = localClouditem
                    self.nameTextField.text = localClouditem.name
                    self.weightTextField.text = localClouditem.weight
                    let unitIndex = self.findIndexOf(Unit: localClouditem.unit, catagory: "")
                    let catagoryIndex = self.findIndexOf(Unit: "", catagory: localClouditem.catagory)
                    self.unitPicker.selectRow(unitIndex, inComponent: 0, animated: false)
                    self.catagoryPicker.selectRow(catagoryIndex, inComponent: 0, animated: false)
                    self.barcodeTextField.text = code
                    if let viewToPopTo = self.viewControllerToPopTo {
                        self.navigationController?.popToViewController(viewToPopTo, animated: true)
                    }else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.inDataBase = false
                    self.cloudItem = nil
                    self.barcodeTextField.text = code
                    if let viewToPopTo = self.viewControllerToPopTo {
                        self.navigationController?.popToViewController(viewToPopTo, animated: true)
                    }else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func findIndexOf(Unit: String, catagory: String) -> Int {
        if Unit != "" {
            for item in PickerViewProperties.units {
                if Unit == item {
                    guard let index = PickerViewProperties.units.index(of: item) else {print("index doesnt exist for catagory"); return 0}
                    return index
                }
            }
        } else {
            for item in PickerViewProperties.catagories {
                if catagory == item {
                    guard let index = PickerViewProperties.catagories.index(of: item) else {print("index doesnt exist for catagory"); return 0}
                    return index
                }
            }
        }
        print("Not unit or catagory")
         return 0
    }
}

extension AddManualItemViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("we got an error")
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

extension AddManualItemViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        print("scanner did dismiss")
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension AddManualItemViewController {
    
    
    /////////////////////////
    //SETOP VIEW TOP STACK
    /////////////////////////
    
    
    func setupAllStackProperties() {
        //MAIN STACK THAT HOLDS IT ALL
        view.addSubview(entryStack)
        entryStack.addArrangedSubview(upperStack)
        entryStack.addArrangedSubview(lowerStack)
        entryStack.axis = .vertical
        entryStack.spacing = 10
        setupStackViewConstraints()
        entryStack.distribution = .fillEqually

        
        upperStack.addArrangedSubview(nameStack)
        upperStack.addArrangedSubview(quantityStack)
        upperStack.addArrangedSubview(weightStack)
        upperStack.axis = .vertical
        upperStack.spacing = 10
        upperStack.distribution = .fillEqually
        lowerStack.addArrangedSubview(unitStack)
        lowerStack.addArrangedSubview(catagoryStack)
        lowerStack.axis = .vertical
        lowerStack.spacing = 5
        lowerStack.distribution = .fillEqually
        
        //NAME STACK
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameTextField)
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        nameStack.distribution = .fill
        nameStack.axis = .horizontal
        nameStack.spacing = 5
        
        //QUANTITY STACK
        quantityStack.addArrangedSubview(quantityLabel)
        quantityStack.addArrangedSubview(quantityTextField)
        quantityTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        quantityStack.distribution = .fill
        quantityStack.axis = .horizontal
        quantityStack.spacing = 5
        
        //WEIGHT STACK
        weightStack.addArrangedSubview(weightLabel)
        weightStack.addArrangedSubview(weightTextField)
        weightTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        weightStack.distribution = .fill
        weightStack.axis = .horizontal
        weightStack.spacing = 5
        
        //UNIT STACK
        unitStack.addArrangedSubview(unitLabel)
        unitStack.addArrangedSubview(unitPickerView)
        unitPickerView.layer.borderWidth = 1
        unitPickerView.layer.borderColor = Colors.softBlue.cgColor
        unitPickerView.layer.cornerRadius = CornerRadius.textField
        unitPickerView.addSubview(unitPicker)
        unitPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        unitStack.distribution = .fill
        unitStack.spacing = 5
        unitStack.axis = .vertical
        
        //CATAGORY STACK
        catagoryStack.addArrangedSubview(catagoryLabel)
        catagoryStack.addArrangedSubview(catagoryPickerView)
        catagoryPickerView.layer.borderWidth = 1
        catagoryPickerView.layer.borderColor = Colors.softBlue.cgColor
        catagoryPickerView.layer.cornerRadius = CornerRadius.textField
        catagoryPickerView.addSubview(catagoryPicker)
        catagoryPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        catagoryStack.backgroundColor = .yellow
        
        catagoryStack.distribution = .fill
        catagoryStack.spacing = 5
        catagoryStack.axis = .vertical
        
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
        unitPicker.delegate = self
        unitPicker.dataSource = self
    }
    
    func setupCatagoryObjects() {
        
        catagoryLabel.text = "Catagory"
        catagoryLabel.textAlignment = .left
        catagoryPicker.delegate = self
        catagoryPicker.dataSource = self
    }
    
    /////////////////////////
    //SETOP VIEW BOTTOM STACK
    /////////////////////////
    
    func setupSingleTap() {
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(disableKeyBoard))
    }
    
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
    
    func setupBarCodeButton() {
        view.addSubview(barcodeButton)
        barcodeButton.frame = CGRect(x: view.frame.width * 0.96 - 50, y: view.frame.height * 0.6, width: 40, height: 40)
        barcodeButton.setImage(#imageLiteral(resourceName: "barCodeButton"), for: .normal)
        barcodeButton.setTitleColor(.white, for: .normal)
        barcodeButton.backgroundColor = Colors.green
        barcodeButton.layer.cornerRadius = 0.5 * barcodeButton.bounds.size.width
        barcodeButton.clipsToBounds = true
        barcodeButton.addTarget(self, action: #selector(barcodeButtonPressed), for: .touchUpInside)
        barcodeButton.addTarget(self, action: #selector(startHighlightBarCode), for: .touchDown)
        barcodeButton.addTarget(self, action: #selector(stopHighlightBarCode), for: .touchUpOutside)
    }
    
    func setupClearButton() {
        view.addSubview(clearButton)
        clearButton.frame = CGRect(x: view.frame.width * 0.052, y: view.frame.height * 0.6, width: 40, height: 40)
        clearButton.setImage(#imageLiteral(resourceName: "ClearBarCodeButton"), for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = Colors.green
        clearButton.layer.cornerRadius = 0.5 * barcodeButton.bounds.size.width
        clearButton.clipsToBounds = true
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(startHighlightclear), for: .touchDown)
        clearButton.addTarget(self, action: #selector(stopHighlightclear), for: .touchUpOutside)
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
    
    func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.frame = CGRect(x: view.frame.width * 0.5 - 25, y: view.frame.height * 0.90, width: 50, height: 50)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = Colors.green
        saveButton.layer.cornerRadius = 0.5 * saveButton.bounds.size.width
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(startHighlightSave), for: .touchDown)
        saveButton.addTarget(self, action: #selector(stopHighlightSave), for: .touchUpOutside)
    }
    
    
    
    ////////////////////////////////////
    //Constraints
    ///////////////////////////////////
    
    func setupStackViewConstraints() {
        entryStack.translatesAutoresizingMaskIntoConstraints = false
        entryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        entryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        entryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        entryStack.bottomAnchor.constraint(equalTo: barCodeStack.topAnchor, constant: -10).isActive = true
    }
    
    func setupBarcodeStackConstraints() {
        barCodeStack.translatesAutoresizingMaskIntoConstraints = false
        barCodeStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.04).isActive = true
        barCodeStack.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.16).isActive = true
        barCodeStack.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 10).isActive = true
        barCodeStack.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -10).isActive = true
        
    }
    
    func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: -20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo:  datePicker.topAnchor, constant: -2).isActive = true
    }
    
    func setupDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints =  false
        datePicker.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.2).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
    }
}

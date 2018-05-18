//
//  AddManualItemViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class AddManualItemViewController: UIViewController, UITextFieldDelegate {
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let quantityLabel = UILabel()
    let quantityTextField = UITextField()
    let barcodeLabel = UILabel()
    let barcodeTextField = UITextField()
    let dateLabel = UILabel()
    let datePicker = UIDatePicker()
    let barCodeStack = UIStackView()
    let entryStack = UIStackView()
    let saveButton = UIButton(type: .custom)
    let barcodeButton = UIButton(type: .custom)
    let clearButton = UIButton(type: .custom)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupObjects()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        doesItemExist()
    }
    
    func setupObjects() {
        setupSaveButton()
        setupDateLabel()
        setupDatePicker()
        setupBarCodeButton()
        setupClearButton()
        setupBarcodeStack()
        setupStackView()
        setupNameLabel()
        setupNameTextField()
        setupQuantityLabel()
        setupQuantityTextField()
        setupBarcodeLabel()
        setupBarCodeTextField()
        setupSingleTap()
    }
    
    
    
    @objc func keyBoardWillShow() {
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func disableKeyBoard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
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
            let shelf = self.shelf else {return}
        let date = datePicker.date
        
        //is there a quantity and is it a number?
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: quantityAsString)) && quantityAsString != "" && name != ""{
            let barcodeNumber = barcodeTextField.text
            let quantity = Double(quantityAsString)
            
            //is there a barcode and is it a number?
            if barcodeNumber != "" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: barcodeNumber!)){
                //does this barcode already exist in the DB?
                if cloudItem != nil && inDataBase == true {
                    CloudItemController.shared.update(cloudItem: self.cloudItem!, name: name) { (success) in
                        //reset the clouditem
                        self.cloudItem = nil
                        self.inDataBase = nil
                        ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, barcode: barcodeNumber!, shelf: shelf)
                        DispatchQueue.main.async {
                            self.presentSaveAlert(WithTitle: "Saved to phone and database updated", message: "Thank you for helping to maintain our database!")
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                        }
                    }
                // barcode doesnt exists in the database
                } else {
                    CloudItemController.shared.createCloudItem(withName: name, barcode: barcodeNumber!) { (success) in
                        //reset the clouditem
                        self.cloudItem = nil
                        self.inDataBase = nil
                        ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, barcode: barcodeNumber!, shelf: shelf)
                        DispatchQueue.main.async {
                      self.presentSaveAlert(WithTitle: "Saved to phone and database", message: "thank you for contributing to our database")
                            self.nameTextField.text = ""
                            self.barcodeTextField.text = ""
                        }
                    }
                }
            //there isnt a barcode number or it isnt a number
            } else {
                ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, barcode: "", shelf: shelf)
                presentSaveAlert(WithTitle: "Saved Successfully", message: "")
                nameTextField.text = ""
                barcodeTextField.text = ""
            }
        //itemName and quantity doesnt exist or quantity isnt a number
        } else {
            presentSaveAlert(WithTitle: "Uh Oh", message: "You need an item name and quantity")
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
}

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
                    self.barcodeTextField.text = code
                    self.navigationController?.popViewController(animated: true)
                    print("exists")
                }
            } else {
                DispatchQueue.main.async {
                    self.inDataBase = false
                    self.cloudItem = nil
                    self.barcodeTextField.text = code
                    self.navigationController?.popViewController(animated: true)
                    print("doesnt exist")
                }
            }
        }
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
    func setupSingleTap() {
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(disableKeyBoard))
    }
    
    func setupStackView() {
        view.addSubview(entryStack)
        entryStack.addArrangedSubview(nameLabel)
        entryStack.addArrangedSubview(nameTextField)
        entryStack.addArrangedSubview(quantityLabel)
        entryStack.addArrangedSubview(quantityTextField)
        entryStack.axis = .vertical
        entryStack.distribution = .fillEqually
        entryStack.spacing = 10
        setupStackViewConstraints()
    }
    
    func setupBarcodeStack() {
        view.addSubview(barCodeStack)
        barCodeStack.addArrangedSubview(barcodeLabel)
        barCodeStack.addArrangedSubview(barcodeTextField)
        barCodeStack.spacing = 10
        barCodeStack.axis = .vertical
        barCodeStack.distribution = .fillProportionally
        setupBarcodeStackConstraints()
    }
    
    func setupNameLabel() {
        nameLabel.text = "Brand + Item Name"
        nameLabel.textAlignment = .left
        nameLabel.tintColor = .white
    }
    
    func setupNameTextField() {
        nameTextField.setLeftPaddingPoints(5)
        nameTextField.placeholder = "Great Value Applesauce"
        nameTextField.layer.cornerRadius = 12
        nameTextField.backgroundColor = .white
        nameTextField.returnKeyType = .done
        self.nameTextField.delegate = self;
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = Colors.softBlue.cgColor
        nameTextField.autocorrectionType = .no
    }
    
    func setupQuantityLabel() {
        quantityLabel.text = "Quantity"
        quantityLabel.textAlignment = .left
        quantityLabel.tintColor = .white
    }
    
    func setupQuantityTextField() {
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
        barcodeButton.frame = CGRect(x: view.frame.width * 0.95 - 50, y: view.frame.height * 0.5 - 28, width: 50, height: 50)
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
        clearButton.frame = CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.5 - 28, width: 50, height: 50)
        clearButton.setTitle("Clear", for: .normal)
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
        dateLabel.textAlignment = .left
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
        saveButton.frame = CGRect(x: view.frame.width * 0.5 - 25, y: view.frame.height * 0.88, width: 50, height: 50)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = Colors.green
        saveButton.layer.cornerRadius = 0.5 * saveButton.bounds.size.width
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(startHighlightSave), for: .touchDown)
        saveButton.addTarget(self, action: #selector(stopHighlightSave), for: .touchUpOutside)
    }
    
    func setupStackViewConstraints() {
        entryStack.translatesAutoresizingMaskIntoConstraints = false
        entryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        entryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        entryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        entryStack.bottomAnchor.constraint(equalTo: barCodeStack.topAnchor, constant: -10).isActive = true
    }
    
    func setupBarcodeStackConstraints() {
        barCodeStack.translatesAutoresizingMaskIntoConstraints = false
        barCodeStack.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        barCodeStack.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 10).isActive = true
        barCodeStack.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -10).isActive = true
        barCodeStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * -0.1).isActive = true
    }
    
    func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 35).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 35 + view.frame.width * 0.1).isActive = true
    }
    
    func setupDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints =  false
        datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
    }
}

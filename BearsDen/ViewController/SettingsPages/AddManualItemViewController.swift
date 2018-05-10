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
    var shelf: Shelf?
    let tapView = UIView()
    let singleTap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupObjects()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func setupObjects() {
        setupBarcodeStack()
        setupStackView()
        setupNameLabel()
        setupNameTextField()
        setupQuantityLabel()
        setupQuantityTextField()
        setupBarcodeLabel()
        setupBarCodeTextField()
        setupSaveButton()
        setupDateLabel()
        setupDatePicker()
        setupBarCodeButton()
        setupSingleTap()
    }
    
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
        barcodeLabel.textAlignment = .left
        barcodeLabel.tintColor = .white
    }
    
    func setupBarCodeTextField() {
        barcodeTextField.backgroundColor = .white
        barcodeTextField.isUserInteractionEnabled = false
        barcodeTextField.placeholder = "  Use Barcode Scanner ->"
        barcodeTextField.layer.cornerRadius = 12
        barcodeTextField.layer.borderWidth = 1
        barcodeTextField.layer.borderColor = Colors.softBlue.cgColor
    }
    
    func setupBarCodeButton() {
        view.addSubview(barcodeButton)
        barcodeButton.frame = CGRect(x: view.frame.height * 0.5 - 50, y: view.frame.width - 70, width: 50, height: 50)
        barcodeButton.setImage(#imageLiteral(resourceName: "barCodeButton"), for: .normal)
        barcodeButton.setTitleColor(.white, for: .normal)
        barcodeButton.backgroundColor = Colors.green
        barcodeButton.layer.cornerRadius = 0.5 * barcodeButton.bounds.size.width
        barcodeButton.clipsToBounds = true
        barcodeButton.addTarget(self, action: #selector(barcodeButtonPressed), for: .touchUpInside)
        barcodeButton.addTarget(self, action: #selector(startHighlightBarCode), for: .touchDown)
        barcodeButton.addTarget(self, action: #selector(stopHighlightBarCode), for: .touchUpOutside)
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
        barCodeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        barCodeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.35).isActive = true
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
        stopHighlightSave()
        guard let name = nameTextField.text, !name.isEmpty,
            let quantityAsString = quantityTextField.text,
            let shelf = self.shelf else {return}
            let date = datePicker.date
       
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: quantityAsString)) && quantityAsString != "" {
            let barcodeNumber = barcodeTextField.text
            let quantity = Double(quantityAsString)
            
            if barcodeNumber != "" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: barcodeNumber!)){
                if let barCode = Int64(barcodeTextField.text!) {
                    ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, barcode: barCode, shelf: shelf)
                    barcodeTextField.text = ""
                }
                print("item saved with barcode")
                //save to api
                
                
                
            } else {
                ItemController.shared.createItemWithAll(name: name, quantity: quantity!, stocked: Date(), expirationDate: date, barcode: 0, shelf: shelf)
                print("item saved without barcode")
            }
            let saveAlert = UIAlertController(title: "Saved Successfully", message: nil, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            saveAlert.addAction(dismiss)
            self.present(saveAlert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Uh Oh", message: "Your item needs a quantity", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension AddManualItemViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("scanner function hit")
        barcodeScanner(controller, didCaptureCode: code, type: type)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("barcodeScanner function hit")
        barcodeTextField.text = code
        controller.reset(animated: true)
        navigationController?.popViewController(animated: true)
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



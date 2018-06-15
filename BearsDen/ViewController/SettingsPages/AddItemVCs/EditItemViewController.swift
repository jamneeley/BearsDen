//
//  EditItemViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/15/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {

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
    let barcodeButton = UIButton(type: .custom)
    let clearButton = UIButton(type: .custom)
    
    //other properties
    var shelf: Shelf?
    let tapView = UIView()
    let singleTap = UITapGestureRecognizer()

    var item: Item? {
        didSet {
            setupObjects()
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
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(saveButtonPressed))

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupObjects() {
        //bottom stack
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
        guard let name = nameTextField.text,
            let quantityAsString = quantityTextField.text,
            let weightAsString = weightTextField.text,
            let item = self.item
            else {return}
        let date = datePicker.date
        let unitIndex = unitPicker.selectedRow(inComponent: 0)
        let catagoryIndex = catagoryPicker.selectedRow(inComponent: 0)
        let unit = PickerViewProperties.units[unitIndex]
        let category = PickerViewProperties.catagories[catagoryIndex]
        var isLiquid = false
        
        if unit == PickerViewProperties.units[2] || unit == PickerViewProperties.units[3] {
            isLiquid = true
        }

        if quantityAsString != "" && name != "" && weightAsString != "", let quantity = quantityAsString.doubleValue, let weight = weightAsString.doubleValue {
        
            let barcodeString = barcodeTextField.text
        
            //is there a barcode and is it a number?
            if barcodeString != "", let barcode = barcodeString?.integerValue {
                print("ITEM SAVED WITH BARCODE")
                ItemController.shared.update(Item: item, name: name, quantity: quantity, expirationDate: date, weight: "\(weight)", isLiquid: isLiquid, unit: unit, catagory: category, barcode: "\(barcode)")
                
            } else {
                print("ITEM SAVED WITHOUT BARCODE")
                ItemController.shared.update(Item: item, name: name, quantity: quantity, expirationDate: date, weight: "\(weight)", isLiquid: isLiquid, unit: unit, catagory: category, barcode: "")
            }
            presentSaveAnimation()
            nameTextField.text = ""
            barcodeTextField.text = ""
            weightTextField.text = ""
        //itemName and quantity doesnt exist or quantity isnt a number
        } else {
            presentSaveAlert(WithTitle: "Uh Oh", message: "You need an item name, quantity and weight")
            return
        }
        self.view.isUserInteractionEnabled = true
        navigationController?.popViewController(animated: true)
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
    

////////////////////////////////////////////////////////
//MARK: - Views
////////////////////////////////////////////////////////
    
    /////////////////////////
    //SETOP VIEW TOP STACK
    /////////////////////////

    func setupAllStackProperties() {
        //MAIN STACK THAT HOLDS IT ALL
        view.addSubview(entryStack)
        entryStack.addArrangedSubview(upperStack)
        entryStack.addArrangedSubview(lowerStack)
        
        upperStack.addArrangedSubview(nameStack)
        upperStack.addArrangedSubview(quantityStack)
        upperStack.addArrangedSubview(weightStack)
        
        lowerStack.addArrangedSubview(unitStack)
        lowerStack.addArrangedSubview(catagoryStack)
        
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
        
        
        entryStack.axis = .vertical
        entryStack.spacing = 10
        entryStack.distribution = .fillEqually
        
        upperStack.axis = .vertical
        upperStack.spacing = 10
        upperStack.distribution = .fillEqually
        
        lowerStack.axis = .vertical
        lowerStack.spacing = 5
        lowerStack.distribution = .fillEqually
        
        //NAME STACK
        
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        nameStack.distribution = .fill
        nameStack.axis = .horizontal
        nameStack.spacing = 5
        
        //QUANTITY STACK
        
        quantityTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        quantityStack.distribution = .fill
        quantityStack.axis = .horizontal
        quantityStack.spacing = 5
        
        //WEIGHT STACK
        
        weightTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.67).isActive = true
        weightStack.distribution = .fill
        weightStack.axis = .horizontal
        weightStack.spacing = 5
        
        //UNIT STACK
        
        unitPickerView.layer.borderWidth = 1
        unitPickerView.layer.borderColor = Colors.softBlue.cgColor
        unitPickerView.layer.cornerRadius = CornerRadius.textField
        
        
        unitStack.distribution = .fill
        unitStack.spacing = 5
        unitStack.axis = .vertical
        
        //CATAGORY STACK
        
        catagoryPickerView.layer.borderWidth = 1
        catagoryPickerView.layer.borderColor = Colors.softBlue.cgColor
        catagoryPickerView.layer.cornerRadius = CornerRadius.textField
        
        catagoryStack.distribution = .fill
        catagoryStack.spacing = 5
        catagoryStack.axis = .vertical
        
        setupStackViewConstraints()
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
        guard let item = self.item else {return}
        nameTextField.text = item.name
    }
    
    func setupQuantityObjects() {
        quantityTextField.setLeftPaddingPoints(5)
        quantityTextField.layer.cornerRadius = 12
        quantityTextField.backgroundColor = .white
        quantityTextField.keyboardType = .decimalPad
        quantityTextField.text = "\(1)"
        quantityTextField.returnKeyType = .done
        self.quantityTextField.delegate = self
        quantityTextField.layer.borderWidth = 1
        quantityTextField.layer.borderColor = Colors.softBlue.cgColor
        quantityTextField.autocorrectionType = .no
        quantityLabel.text = "Quantity"
        quantityLabel.textAlignment = .left
        guard let quantity = self.item?.quantity else {return}
        quantityTextField.text = "\(quantity)"
    }
    
    func setupWeightObjects() {
        weightLabel.text = "Weight"
        weightLabel.textAlignment = .left
        weightTextField.placeholder = "0"
        weightTextField.layer.cornerRadius = 12
        weightTextField.setLeftPaddingPoints(5)
        weightTextField.backgroundColor = .white
        weightTextField.keyboardType = .decimalPad
        self.nameTextField.delegate = self;
        weightTextField.layer.borderWidth = 1
        weightTextField.layer.borderColor = Colors.softBlue.cgColor
        weightTextField.autocorrectionType = .no
        guard let weight = self.item?.weight else {return}
        weightTextField.text = weight
    }
    
    func setupUnitObjects() {
        unitLabel.text = "Unit"
        unitLabel.textAlignment = .left
        unitPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        unitPicker.delegate = self
        unitPicker.dataSource = self
        guard let unit = self.item?.unit else {return}
        let unitIndex = findIndexOf(Unit: unit, catagory: "")
        unitPicker.selectRow(unitIndex, inComponent: 0, animated: false)
    }
    
    func setupCatagoryObjects() {
        catagoryLabel.text = "Catagory"
        catagoryLabel.textAlignment = .left
        catagoryPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        catagoryPicker.delegate = self
        catagoryPicker.dataSource = self
        guard let category = self.item?.catagory else {return}
        let categoryIndex = findIndexOf(Unit: "", catagory: category)
        catagoryPicker.selectRow(categoryIndex, inComponent: 0, animated: false)
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
        guard let barcode = self.item?.barcode else {return}
        barcodeTextField.text = barcode
    }
    
    func setupBarCodeButton() {
        view.addSubview(barcodeButton)
        barcodeButton.frame = CGRect(x: view.frame.width * 0.96 - 50, y: view.frame.height * 0.67, width: 40, height: 40)
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
        clearButton.frame = CGRect(x: view.frame.width * 0.052, y: view.frame.height * 0.67, width: 40, height: 40)
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
        datePicker.layer.cornerRadius = 12
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = Colors.softBlue.cgColor
        setupDatePickerConstraints()
        guard let expDate = self.item?.expirationDate else {return}
        datePicker.date = expDate
    }

    
    func setupStackViewConstraints() {
        entryStack.translatesAutoresizingMaskIntoConstraints = false
        entryStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.02).isActive = true
        entryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        entryStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        entryStack.bottomAnchor.constraint(equalTo: barCodeStack.topAnchor, constant: -10).isActive = true
    }
    
    func setupBarcodeStackConstraints() {
        barCodeStack.translatesAutoresizingMaskIntoConstraints = false
        barCodeStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.1).isActive = true
        barCodeStack.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: view.frame.height * -0.02).isActive = true
        barCodeStack.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 10).isActive = true
        barCodeStack.trailingAnchor.constraint(equalTo: barcodeButton.leadingAnchor, constant: -10).isActive = true
        
    }
    
    func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: -32).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo:  datePicker.topAnchor, constant: -12).isActive = true
    }
    
    func setupDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints =  false
        datePicker.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.3).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.05).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
    }
}

//MARK: - BARCODE SCANNER METHODS

extension EditItemViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        barcodeScanner(controller, didCaptureCode: code, type: type)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
            self.barcodeTextField.text = code
            self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditItemViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("we got an error")
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

extension EditItemViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        print("scanner did dismiss")
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}




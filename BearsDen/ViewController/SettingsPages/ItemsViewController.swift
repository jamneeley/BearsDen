//
//  ItemsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemCellDelegate, shelfEditViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let itemTableView = UITableView()
    var shelf: Shelf?
    let manualAddButton = UIButton(type: .custom)
    let barCodeAddButton = UIButton(type: .custom)
    let blackView = UIView()
    let editShelfView = ShelfEditView()

    
    var newShelfName: String?
    var newShelfImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        itemTableView.delegate = self
        setupObjects()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        itemTableView.reloadData()
    }
    
    func setupObjects() {
        setupTableView()
        setupNavigationBar()
        setupManualAddButton()
        setupBarCodeAddButton()
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editShelfButtonPressed() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(editShelfView)
            editShelfView.delegate = self
            
            if let shelf = self.shelf {
                editShelfView.shelf = shelf
            }
            
            let width = window.frame.width * 0.8
            let height = window.frame.height * 0.75
            
            editShelfView.frame = CGRect(x: (window.frame.width - width), y: -(window.frame.height), width: width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.editShelfView.frame = CGRect(x: (window.frame.width - width) / 2, y: (window.frame.height - height) / 2, width: self.editShelfView.frame.width, height: self.editShelfView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.editShelfView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.editShelfView.frame.width, height: self.editShelfView.frame.height)
            }
        }) { (success) in
            print("animation complete")
        }
    }
    
    func selectLibraryPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func selectCameraPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            guard let shelf = self.shelf else {return}
            ShelfController.shared.ChangePictureforShelf(Shelf: shelf, photo: image)
            editShelfView.shelfImage = image
        } else {
            print("error picking image from imagepicker")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func startHighlightManual() {
        manualAddButton.layer.backgroundColor = Colors.softBlue.cgColor
        manualAddButton.imageView?.tintColor = .white
    }
    @objc func stopHighlightManual() {
        manualAddButton.layer.backgroundColor = Colors.green.cgColor
        manualAddButton.imageView?.tintColor = nil
    }
    @objc func startHighlightBar() {
        barCodeAddButton.layer.backgroundColor = Colors.softBlue.cgColor
        barCodeAddButton.imageView?.tintColor = .white

    }
    @objc func stopHighlightBar() {
        barCodeAddButton.layer.backgroundColor = Colors.green.cgColor
        barCodeAddButton.imageView?.tintColor = nil
    }
    @objc func addManualButtonPressed() {
        stopHighlightManual()
        let addManualView = AddManualItemViewController()
        addManualView.shelf = self.shelf
        navigationController?.pushViewController(addManualView, animated: true)
    }
    
    @objc func addBarButtonPressed() {
        stopHighlightBar()
        let codeScannerViewController = BarcodeScannerViewController()
        codeScannerViewController.codeDelegate = self
        codeScannerViewController.errorDelegate = self
        codeScannerViewController.dismissalDelegate = self
        navigationController?.pushViewController(codeScannerViewController, animated: true)
    }
    
    @objc func changeShelfImageTapped(){
        print("tapped")
    }
    
    func addedToShoppingList(itemName: String) {
        let alert = UIAlertController(title: "\(itemName) has been added to your shopping list", message: nil, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelf?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "itemCell")
        
        itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        if shelf != nil {
            if let item = shelf?.items?[indexPath.row] as? Item {
                cell.delegate = self
                cell.item = item
                return cell
            }
        } else {
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let shelf = self.shelf,
            let item = shelf.items?[indexPath.row] as? Item else {return}
            ItemController.shared.delete(Item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ItemsViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        self.barcodeScanner(controller, didCaptureCode: code, type: type)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        
        CloudItemController.shared.fetchCloudItem(WithBarcode: code) { (cloudItem) in
            if let cloudItem = cloudItem {
                DispatchQueue.main.async {
                    guard let shelf = self.shelf else {return}
                    let barCodeController = AddBarcodeViewController()
                    self.navigationController?.popViewController(animated: true)
                    self.navigationController?.pushViewController(barCodeController, animated: true)
                    barCodeController.cloudItem = cloudItem
                    barCodeController.shelf = shelf
                }
            } else {
                DispatchQueue.main.async {
                    let addManualController = AddManualItemViewController()
                    self.navigationController?.popViewController(animated: true)
                    self.navigationController?.pushViewController(addManualController, animated: true)
                    addManualController.shelf = self.shelf
                    addManualController.barcode = code
                    addManualController.itemExists = false
                }
            }
        }
    }
}

extension ItemsViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print("we got an error")
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

extension ItemsViewController: BarcodeScannerDismissalDelegate {
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

extension ItemsViewController {
    
    func setupTableView() {
        view.addSubview(itemTableView)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        setupTableViewConstraints()
    }

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editShelfButtonPressed))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = shelf?.name
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = Colors.softBlue
    }
    
    func setupManualAddButton() {
        manualAddButton.frame = CGRect(x: view.frame.width * 0.35 - 30, y: view.frame.height * 0.88, width: 65, height: 65)
        view.addSubview(manualAddButton)
        manualAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        manualAddButton.layer.shadowColor = Colors.mediumGray.cgColor
        manualAddButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        manualAddButton.layer.shadowColor = Colors.mediumGray.cgColor
        manualAddButton.layer.masksToBounds = false
        manualAddButton.layer.shadowOpacity = 1.0
        manualAddButton.layer.shadowRadius = 10.0
        manualAddButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        manualAddButton.imageView?.tintColor = nil
        manualAddButton.setImage(#imageLiteral(resourceName: "ClipBoardButton"), for: .normal)
        manualAddButton.backgroundColor = Colors.green
        manualAddButton.addTarget(self, action: #selector(startHighlightManual), for: .touchDown)
        manualAddButton.addTarget(self, action: #selector(addManualButtonPressed), for: .touchUpInside)
        manualAddButton.addTarget(self, action: #selector(stopHighlightManual), for: .touchUpOutside)
    }
    
    func setupBarCodeAddButton() {
        barCodeAddButton.frame = CGRect(x: view.frame.width * 0.65 - 30, y: view.frame.height * 0.88, width: 65, height: 65)
        view.addSubview(barCodeAddButton)
        barCodeAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        barCodeAddButton.layer.shadowColor = Colors.mediumGray.cgColor
        barCodeAddButton.layer.masksToBounds = false
        barCodeAddButton.layer.shadowOpacity = 1.0
        barCodeAddButton.layer.shadowRadius = 10.0
        barCodeAddButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        barCodeAddButton.imageView?.tintColor = nil
        barCodeAddButton.setImage(#imageLiteral(resourceName: "barCodeButton"), for: .normal)
        barCodeAddButton.backgroundColor = Colors.green
        barCodeAddButton.addTarget(self, action: #selector(startHighlightBar), for: .touchDown)
        barCodeAddButton.addTarget(self, action: #selector(addBarButtonPressed), for: .touchUpInside)
        barCodeAddButton.addTarget(self, action: #selector(stopHighlightBar), for: .touchUpOutside)
    }
    
    func setupTableViewConstraints() {
        itemTableView.translatesAutoresizingMaskIntoConstraints = false
        itemTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        itemTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        itemTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        itemTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}




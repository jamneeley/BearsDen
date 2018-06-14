//
//  SettingsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI


class Setting {
    
    let title: String
    let object: UIView
    let number: Int
    
    init(title: String, object: UIView, number: Int) {
        self.title = title
        self.object = object
        self.number = number
    }
}

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SettingCellDelegate {

    let settings: [Setting] = {

        let denName = Setting(title: "Den Name", object: UITextField(), number: 1)
        let adults = Setting(title: "Adults:", object: UIStepper(), number: 2)
        let kids = Setting(title: "Kids:", object: UIStepper(), number: 3)
//        let colorScheme = Setting(title: "Color Scheme", object: UISwitch(), settingVariable: "", number: 4)
        let showTutorial = Setting(title: "Tutorial", object: UIButton(),number: 4)
        let questions = Setting(title: "Questions?", object: UILabel(), number: 5)
        let donate = Setting(title: "Donate to Developer", object: UIButton(), number: 6)
        let rateUS = Setting(title: "Rate Us", object: UIButton(), number: 7)
        
        return [denName, adults, kids, showTutorial, questions, donate, rateUS]
    }()
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        tableView.reloadData()
    }
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let denImageView = UIImageView()
    let photoLibraryButton = UIButton(type: .custom)
    let cameraButton = UIButton(type: .custom)
    let singleTap = UITapGestureRecognizer()
    let tableView = UITableView()
    let cellID = "settingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = Colors.veryLightGray
        setupObjects()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillshow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }

    func setupObjects() {
        setupScrollView()
        setupContentView()
        setupDenImageView()
        setupPhotoLibraryButton()
        setupCameraButton()
        setupTableView()
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(endEditing))
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            denImageView.image = image
            UserController.shared.change(Picture: image)
        } else {
            print("error picking image from imagepicker")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CELL DELEGATE
    
    func settingActionTaken(settingNumber: Int) {
        switch settingNumber {
        case 1:
            print("denNameCell, this should not be called")
        case 2:
            print("adultsStepper, this should not be called")
        case 3:
            print("kidsStepper, this should not be called")
        case 4:
            let tutorialViewController = TutorialOptionsViewController()
            let navController = UINavigationController(rootViewController: tutorialViewController)
            self.present(navController, animated: true, completion: nil)
        case 5:
            print("questionsCell, this should not be called")
        case 6:
            let alert = UIAlertController(title: "Coming Soon", message: "Thank you for wanting to donate :)", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
        case 7:
            SKStoreReviewController.requestReview()
        default:
            print("setting number passed to delegate is out of range")
        }
    }
    
    @objc func startHighlightLibrary() {
        photoLibraryButton.backgroundColor = Colors.softBlue
        photoLibraryButton.tintColor = .white
    }
    
    @objc func stopHighlightLibrary() {
        photoLibraryButton.backgroundColor = Colors.green
        photoLibraryButton.tintColor = nil
    }
    
    @objc func libraryButtonPressed() {
        stopHighlightLibrary()
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    @objc func startHighlightCamera() {
        cameraButton.backgroundColor = Colors.softBlue
        cameraButton.tintColor = .white
    }
    
    @objc func stopHighlightCamera() {
        cameraButton.backgroundColor = Colors.green
        cameraButton.tintColor = nil
    }
    
    @objc func CameraButtonPressed() {
        stopHighlightCamera()
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @objc func keyBoardWillshow() {
        //        view.frame.origin.y = -50
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func keyBoardWillHide() {
        //        view.frame.origin.y = view.frame.height * 0.08
        view.removeGestureRecognizer(singleTap)
    }

    
    //MARK: - TableView Data Source
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My Den"
        case 1:
            return "App Help"
        case 2:
            return "Like Bears Den?"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingTableViewCell
        cell.delegate = self
        switch indexPath.section {
        case 0:
            let setting = settings[indexPath.row]
            cell.setting = setting
            return cell
        case 1:
            let setting = settings[indexPath.row + 3]
            cell.setting = setting
            return cell
        case 2:
            let setting = settings[indexPath.row + 5]
            cell.setting = setting
            return cell
        default:
            return cell
        }
    }
    
    
    //MARK: - Constraints
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = Colors.veryLightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 1.3).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    
    func setupDenImageView() {
        guard let userimageData = UserController.shared.user?.picture else {return}
        let image = UIImage(data: userimageData)
        denImageView.image = image
        denImageView.layer.masksToBounds = true
        denImageView.layer.cornerRadius = CornerRadius.imageView
        setupDenImageViewConstraints()
    }
    
    func setupDenImageViewConstraints() {
        contentView.addSubview(denImageView)
        denImageView.layer.cornerRadius = 12
        denImageView.translatesAutoresizingMaskIntoConstraints = false
        denImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        denImageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.25).isActive = true
        
        NSLayoutConstraint(item: denImageView, attribute: .height, relatedBy: .equal, toItem: denImageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        denImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupPhotoLibraryButton() {
        contentView.addSubview(photoLibraryButton)
        photoLibraryButton.frame = CGRect(x: (view.frame.size.width * 0.5) - 70, y: (view.bounds.size.height * 0.25 + 10), width: 40, height: 40)
        photoLibraryButton.setImage(#imageLiteral(resourceName: "photoLibrary"), for: .normal)
        photoLibraryButton.tintColor = .black
        photoLibraryButton.backgroundColor = Colors.green
        photoLibraryButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        photoLibraryButton.addTarget(self, action: #selector(startHighlightLibrary), for: .touchDown)
        photoLibraryButton.addTarget(self, action: #selector(stopHighlightLibrary), for: .touchUpOutside)
        photoLibraryButton.addTarget(self, action: #selector(libraryButtonPressed), for: .touchUpInside)
    }
    
    func setupCameraButton() {
        contentView.addSubview(cameraButton)
        cameraButton.frame = CGRect(x: (view.frame.size.width * 0.5) + 30, y: (view.bounds.size.height * 0.25) + 10, width: 40, height: 40)
        cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.backgroundColor = Colors.green
        cameraButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        cameraButton.addTarget(self, action: #selector(startHighlightCamera), for: .touchDown)
        cameraButton.addTarget(self, action: #selector(stopHighlightCamera), for: .touchUpOutside)
        cameraButton.addTarget(self, action: #selector(CameraButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView() {
        contentView.addSubview(tableView)
        tableView.separatorColor = Colors.lightGray
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.35).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentView.frame.width * 0.01).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: contentView.frame.width * -0.01).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: contentView.frame.height * -0.05).isActive = true
    }
}

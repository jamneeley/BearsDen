//
//  MyDenViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MyDenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let denImageView = UIImageView()
    let photoLibraryButton = UIButton(type: .custom)
    let cameraButton = UIButton(type: .custom)
    let nameStack = UIStackView()
    let denNameLabel = UILabel()
    let denTextField = UITextField()
    let adultStack = UIStackView()
    let denAdultsLabel = UILabel()
    let denAdultsNumberLabel = UILabel()
    let denAdultsStepper = UIStepper()
    let kidStack = UIStackView()
    let denKidsLabel = UILabel()
    let denKidsNumberLabel = UILabel()
    let denKidsStepper = UIStepper()
    let saveButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupObjects()
    }

    
    func setupObjects() {
        view.addSubview(denImageView)
        view.addSubview(photoLibraryButton)
        view.addSubview(cameraButton)
        view.addSubview(nameStack)
        view.addSubview(saveButton)
        view.addSubview(adultStack)
        view.addSubview(kidStack)
        setupDenImageView()
        setupPhotoLibraryButton()
        setupCameraButton()
        setupNameStack()
        setupDenNameLabel()
        setupDenTextField()
        setupAdultStack()
        setupKidStack()
        setupDenAdultsLabel()
        setupDenAdultsNumberLabel()
        setupDenAdultsStepper()
        setupDenKidsLabel()
        setupDenKidsNumberLabel()
        setupDenKidsStepper()
        setupSaveButton()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            denImageView.image = image
        } else {
            print("error picking image from imagepicker")
        }
        self.dismiss(animated: true, completion: nil)
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
    
    @objc func startHighlightSave() {
        saveButton.backgroundColor = Colors.softBlue
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func stopHighlightSave() {
        saveButton.backgroundColor = Colors.green
        saveButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func saveButtonPressed() {
        guard let name = denTextField.text,
            !name.isEmpty,
            let kids = denKidsNumberLabel.text,
            !kids.isEmpty,
            let adults = denAdultsNumberLabel.text,
            !adults.isEmpty,
            let picture = denImageView.image
            else {return}
        
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: kids)) && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: adults)) {
            UserController.shared.updateUser(HouseholdName: name, picture: picture, adults: adults, kids: kids)
        }
        saveAnimation()
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
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension MyDenViewController {
    
    func setupDenImageView() {
        guard let userimageData = UserController.shared.user?.picture else {return}
        let image = UIImage(data: userimageData)
        denImageView.image = image
        setupDenImageViewConstraints()
    }
    
    func setupPhotoLibraryButton() {
        photoLibraryButton.frame = CGRect(x: (view.frame.size.width * 0.5) - 80, y: (view.bounds.size.height * 0.35 + 20), width: 50, height: 50)
        photoLibraryButton.setImage(#imageLiteral(resourceName: "photoLibrary"), for: .normal)
        photoLibraryButton.tintColor = .black
        photoLibraryButton.backgroundColor = Colors.green
        photoLibraryButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        photoLibraryButton.addTarget(self, action: #selector(startHighlightLibrary), for: .touchDown)
        photoLibraryButton.addTarget(self, action: #selector(stopHighlightLibrary), for: .touchUpOutside)
        photoLibraryButton.addTarget(self, action: #selector(libraryButtonPressed), for: .touchUpInside)
    }
    
    func setupCameraButton() {
        cameraButton.frame = CGRect(x: (view.frame.size.width * 0.5) + 30, y: (view.bounds.size.height * 0.35) + 20, width: 50, height: 50)
        cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.backgroundColor = Colors.green
        cameraButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        cameraButton.addTarget(self, action: #selector(startHighlightCamera), for: .touchDown)
        cameraButton.addTarget(self, action: #selector(stopHighlightCamera), for: .touchUpOutside)
        cameraButton.addTarget(self, action: #selector(CameraButtonPressed), for: .touchUpInside)
    }
    
    func setupDenNameLabel() {
        denNameLabel.text = "Den Name"
        denNameLabel.textAlignment = .center
    }
    
    func setupDenTextField() {
        guard let userName = UserController.shared.user?.houseHoldName else {return}
        denTextField.text = userName
        denTextField.setLeftPaddingPoints(5)
        denTextField.layer.borderWidth = 1
        denTextField.layer.borderColor = Colors.softBlue.cgColor
        denTextField.layer.cornerRadius = 12
    }
    
    func setupNameStack() {
        nameStack.addArrangedSubview(denNameLabel)
        nameStack.addArrangedSubview(denTextField)
        nameStack.axis = .vertical
        nameStack.backgroundColor = .black
        nameStack.distribution = .fillEqually
        setupNameStackConstraints()
    }

    func setupDenAdultsLabel() {
        denAdultsLabel.text = "Adults"
        denAdultsLabel.textAlignment = .center
        
    }
    
    func setupDenAdultsNumberLabel() {
        let userAdults = UserController.shared.user?.adults
        denAdultsNumberLabel.text = "\(userAdults ?? "0")"
        denAdultsNumberLabel.textAlignment = .center
    }
    
    func setupDenAdultsStepper() {
        guard let user = UserController.shared.user else {return}
        let adults = user.adults ?? "0"
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: adults)){
        denAdultsStepper.stepValue = 1
        denAdultsStepper.value = Double(adults)!
        denAdultsStepper.maximumValue = 50.0
        denAdultsStepper.isContinuous = false
        denAdultsStepper.autorepeat = false
        denAdultsStepper.addTarget(self, action: #selector(adultsStepperTouched), for: .touchUpInside)
        }
    }
    
    @objc func adultsStepperTouched() {
        let adultsNumber = Int(denAdultsStepper.value)
        denAdultsNumberLabel.text = "\(adultsNumber)"
    }
    
    func setupAdultStack() {
        adultStack.axis = .vertical
        adultStack.distribution = .fillEqually
        adultStack.spacing = 8
        adultStack.addArrangedSubview(denAdultsLabel)
        adultStack.addArrangedSubview(denAdultsNumberLabel)
        adultStack.addArrangedSubview(denAdultsStepper)
        setupAdultStackConstraints()
    }
    
    func setupDenKidsLabel() {
        denKidsLabel.text = "Kids"
        denKidsLabel.textAlignment = .center
    }
    
    func setupDenKidsNumberLabel() {
        let userKids = UserController.shared.user?.kids
        denKidsNumberLabel.text = "\(userKids ?? "0")"
        denKidsNumberLabel.textAlignment = .center
    }
    
    func setupDenKidsStepper() {
        guard let user = UserController.shared.user else {return}
        let kids = user.kids ?? "0"
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: kids)){
            denKidsStepper.stepValue = 1
            denKidsStepper.value = Double(kids)!
            denKidsStepper.maximumValue = 50.0
            denKidsStepper.isContinuous = false
            denKidsStepper.autorepeat = false
            denKidsStepper.addTarget(self, action: #selector(kidsStepperTouched), for: .touchUpInside)
        }
    }
    
    @objc func kidsStepperTouched() {
        let kidsNumber = Int(denKidsStepper.value)
        denKidsNumberLabel.text = "\(kidsNumber)"
    }
    
    
    func setupKidStack() {
        kidStack.axis = .vertical
        kidStack.spacing = 8
        kidStack.distribution = .fillEqually
        kidStack.addArrangedSubview(denKidsLabel)
        kidStack.addArrangedSubview(denKidsNumberLabel)
        kidStack.addArrangedSubview(denKidsStepper)
        setupKidsStackConstraints()
    }
    
    func setupSaveButton() {
        saveButton.frame = CGRect(x: (view.frame.size.width * 0.5) - 25, y: (view.bounds.size.height * 0.9) - 50 , width: 50, height: 50)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = Colors.green
        saveButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        saveButton.addTarget(self, action: #selector(startHighlightSave), for: .touchDown)
        saveButton.addTarget(self, action: #selector(stopHighlightSave), for: .touchUpOutside)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    func setupDenImageViewConstraints() {
        denImageView.translatesAutoresizingMaskIntoConstraints = false
        denImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        denImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.35).isActive = true
        NSLayoutConstraint(item: denImageView, attribute: .height, relatedBy: .equal, toItem: denImageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        denImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    func setupNameStackConstraints() {
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        nameStack.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.size.height * 0.35) + 80).isActive = true
        nameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        nameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        nameStack.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.1).isActive = true
    }
    
    func setupAdultStackConstraints() {
        adultStack.translatesAutoresizingMaskIntoConstraints = false
        adultStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 20).isActive = true
        adultStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.width * 0.1).isActive = true
        adultStack.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.size.width * -0.1).isActive = true
        adultStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:(view.bounds.size.height * -0.1) - 50).isActive = true
    }
    
    func setupKidsStackConstraints() {
        kidStack.translatesAutoresizingMaskIntoConstraints = false
        kidStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 20).isActive = true
        kidStack.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.size.width * 0.1).isActive = true
        kidStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.size.width * -0.1).isActive = true
        kidStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (view.bounds.size.height * -0.1) - 50).isActive = true
    }
}


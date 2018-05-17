//
//  ShelfEditViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/16/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
protocol shelfEditViewDelegate: class {
    func handleDismiss()
    func selectLibraryPhoto()
    func selectCameraPhoto()
}

class ShelfEditView: UIView, UITextFieldDelegate {
    
    var shelf: Shelf?
    var shelfImage: UIImage?
    
    let shelfNameLabel = UILabel()
    let shelfTextField = UITextField()
    let shelfImageView = UIImageView()
    let photoLibraryButton = UIButton(type: .custom)
    let cameraButton = UIButton(type: .custom)
    let dismissButton = UIButton(type: .custom)
    let saveButton = UIButton(type: .custom)
    weak var delegate: shelfEditViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupEditShelfView()
        shelfTextField.delegate = self
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
        
    @objc func dismissButtonTapped() {
        delegate?.handleDismiss()
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    @objc func startHighlightLibrary() {
        photoLibraryButton.layer.backgroundColor = Colors.softBlue.cgColor
        photoLibraryButton.imageView?.tintColor = .white
    }
    
    @objc func stopHighlightLibrary() {
        photoLibraryButton.layer.backgroundColor = Colors.green.cgColor
        photoLibraryButton.imageView?.tintColor = nil
    }
    
    @objc func libraryButtonPressed() {
        delegate?.selectLibraryPhoto()
    }
    @objc func startHighlightCamera() {
        cameraButton.layer.backgroundColor = Colors.softBlue.cgColor
        cameraButton.imageView?.tintColor = .white
    }
    
    @objc func stopHighlightCamera() {
        cameraButton.layer.backgroundColor = Colors.green.cgColor
        cameraButton.imageView?.tintColor = nil
    }
    
    @objc func CameraButtonPressed() {
        stopHighlightLibrary()
        delegate?.selectCameraPhoto()
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension ShelfEditView {
    func setupEditShelfView() {
        self.addSubview(shelfNameLabel)
        self.addSubview(shelfTextField)
        self.addSubview(shelfImageView)
        self.addSubview(photoLibraryButton)
        self.addSubview(cameraButton)
        self.addSubview(dismissButton)
        self.addSubview(saveButton)
        setupShelfNameLabel()
        setupShelfTextField()
        setupShelfImageView()
        setupPhotoLibraryButton()
        setupCameraButton()
        setupDismissButton()
        setupSaveButton()
    }
    
    func setupShelfNameLabel() {
        shelfNameLabel.text = "Shelf Name"
        shelfNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shelfNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        shelfNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        shelfNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    func  setupShelfTextField() {
        shelfTextField.returnKeyType = .done
        shelfTextField.autocorrectionType = UITextAutocorrectionType.no
        shelfTextField.layer.borderWidth = 1
        shelfTextField.layer.borderColor = Colors.softBlue.cgColor
        shelfTextField.layer.cornerRadius = 12
        shelfTextField.translatesAutoresizingMaskIntoConstraints = false
        shelfTextField.bottomAnchor.constraint(equalTo: shelfNameLabel.bottomAnchor, constant: 40).isActive = true
        shelfTextField.topAnchor.constraint(equalTo: shelfNameLabel.bottomAnchor, constant: 10).isActive = true
        shelfTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        shelfTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        if let shelf = shelf {
            shelfTextField.text = shelf.name
        } else {
            shelfTextField.placeholder = "Canned Goods"
        }
    }
    
    func setupShelfImageView() {
        shelfImageView.translatesAutoresizingMaskIntoConstraints = false
        shelfImageView.topAnchor.constraint(equalTo: shelfTextField.bottomAnchor, constant: 10).isActive = true
        shelfImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        shelfImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        shelfImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 60).isActive = true
        if let shelf = shelf, let photoAsData = shelf.photo {
            let photo = UIImage(data: photoAsData)
            shelfImageView.image = photo
        } else {
            shelfImageView.image = #imageLiteral(resourceName: "BearOnHill")
        }
    }

    func setupPhotoLibraryButton() {
        photoLibraryButton.frame.size = CGSize(width: 50.0, height: 50.0)
        photoLibraryButton.setImage(#imageLiteral(resourceName: "photoLibrary"), for: .normal)
        photoLibraryButton.tintColor = .black
        photoLibraryButton.backgroundColor = Colors.green
        photoLibraryButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        photoLibraryButton.addTarget(self, action: #selector(startHighlightLibrary), for: .touchDown)
        photoLibraryButton.addTarget(self, action: #selector(stopHighlightLibrary), for: .touchUpOutside)
        photoLibraryButton.addTarget(self, action: #selector(libraryButtonPressed), for: .touchUpInside)
        photoLibraryButton.translatesAutoresizingMaskIntoConstraints = false
        photoLibraryButton.topAnchor.constraint(equalTo: shelfImageView.bottomAnchor , constant: 20).isActive = true
        photoLibraryButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -70).isActive = true
    }
    
    func setupCameraButton() {
        cameraButton.frame.size = CGSize(width: 50, height: 50)
        cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.backgroundColor = Colors.green
        cameraButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
        cameraButton.addTarget(self, action: #selector(startHighlightCamera), for: .touchDown)
        cameraButton.addTarget(self, action: #selector(stopHighlightCamera), for: .touchUpOutside)
        cameraButton.addTarget(self, action: #selector(CameraButtonPressed), for: .touchUpInside)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.topAnchor.constraint(equalTo: shelfImageView.bottomAnchor , constant: 20).isActive = true
        cameraButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 70).isActive = true
    }
    func setupDismissButton() {
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = Colors.softBlue.cgColor
        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        dismissButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
    
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = Colors.softBlue.cgColor
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        saveButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
    }
    
   
}

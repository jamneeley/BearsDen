//
//  ShelfEditViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/16/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

//MARK: - Delegate Protocol

protocol shelfEditViewDelegate: class {
    func handleDismiss()
    func selectLibraryPhoto()
    func selectCameraPhoto()
}

class ShelfEditViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    var shelf: Shelf? {
        didSet {
            updateViews()
        }
    }
    var shelfImage: UIImage? {
        didSet {
            stopHighlightCamera()
            stopHighlightLibrary()
            updatePicture()
        }
    }
    
    let shelfNameLabel = UILabel()
    let shelfTextField = UITextField()
    let shelfImageView = UIImageView()
    let photoLibraryButton = UIButton(type: .custom)
    let cameraButton = UIButton(type: .custom)
    let dismissButton = UIButton(type: .custom)
    let saveButton = UIButton(type: .custom)
    weak var delegate: shelfEditViewDelegate?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupEditShelfView()
        shelfTextField.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateViews()
    }
    
    //MARK: - Update Methods
    
    func updateViews() {
        guard let shelf = shelf, let image = shelfImage else {return}
        print("update success")
        shelfTextField.text = shelf.name
        shelfImageView.image = image
        
    }
    
    func updatePicture() {
        guard let image = shelfImage else {return}
        shelfImageView.image = image
        
    }
    
    //MARK: - Button Methods
    
    @objc func saveButtonTapped() {
        stopHighlightSave()
        guard let image = shelfImageView.image,
            let name = shelfTextField.text, !name.isEmpty,
            let user = UserController.shared.user,
            let shelfImage = shelfImage
            else {return}
        if let shelf = shelf {
            ShelfController.shared.ChangePictureforShelf(Shelf: shelf, photo: shelfImage)
            ShelfController.shared.updateName(Shelf: shelf, name: name)
            delegate?.handleDismiss()
        } else {
            ShelfController.shared.createShelfForUser(User: user, name: name, photo: image)
            shelfTextField.text = ""
            shelfImageView.image = #imageLiteral(resourceName: "BearOnHill")
            delegate?.handleDismiss()
        }
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
    
    @objc func startHighlightDismiss() {
        dismissButton.backgroundColor = Colors.softBlue
        dismissButton.setTitleColor(.white, for: .normal)
    }
    @objc func stopHighlightDismiss() {
        dismissButton.backgroundColor = .white
        dismissButton.setTitleColor(.black, for: .normal)
    }
    @objc func startHighlightSave() {
        saveButton.backgroundColor = Colors.softBlue
        saveButton.setTitleColor(.white, for: .normal)
       
    }
    @objc func stopHighlightSave() {
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func dismissButtonTapped() {
        delegate?.handleDismiss()
        stopHighlightDismiss()
    }
}

////////////////////////////////////////////////////////
//MARK: - Views
////////////////////////////////////////////////////////

extension ShelfEditViewController {
    func setupEditShelfView() {
        view.addSubview(shelfNameLabel)
        view.addSubview(shelfTextField)
        view.addSubview(shelfImageView)
        view.addSubview(photoLibraryButton)
        view.addSubview(cameraButton)
        view.addSubview(dismissButton)
        view.addSubview(saveButton)
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
        shelfNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        shelfNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        shelfNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupShelfTextField() {
        shelfTextField.setLeftPaddingPoints(10)
        shelfTextField.setRightPaddingPoints(10)
        shelfTextField.returnKeyType = .done
        shelfTextField.autocorrectionType = UITextAutocorrectionType.no
        shelfTextField.layer.borderWidth = 1
        shelfTextField.layer.borderColor = Colors.softBlue.cgColor
        shelfTextField.layer.cornerRadius = 12
        shelfTextField.translatesAutoresizingMaskIntoConstraints = false
        shelfTextField.bottomAnchor.constraint(equalTo: shelfNameLabel.bottomAnchor, constant: 40).isActive = true
        shelfTextField.topAnchor.constraint(equalTo: shelfNameLabel.bottomAnchor, constant: 10).isActive = true
        shelfTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        shelfTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        if let shelf = shelf {
            shelfTextField.text = shelf.name
        } else {
            shelfTextField.placeholder = "Canned Goods"
        }
    }
    
    func setupShelfImageView() {
        shelfImageView.layer.masksToBounds = true
        shelfImageView.layer.cornerRadius = CornerRadius.imageView
        shelfImageView.translatesAutoresizingMaskIntoConstraints = false
        shelfImageView.topAnchor.constraint(equalTo: shelfTextField.bottomAnchor, constant: 10).isActive = true
        shelfImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        shelfImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        shelfImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        if let shelf = shelf, let photoAsData = shelf.photo {
            let photo = UIImage(data: photoAsData)
            shelfImageView.image = photo
        } else {
            shelfImageView.image = #imageLiteral(resourceName: "BearOnHill")
        }
    }

    func setupPhotoLibraryButton() {
            photoLibraryButton.frame = CGRect(x: (view.frame.size.width * 0.5) - (view.frame.width * 0.2) - 50, y: (view.bounds.size.height * 0.5)  - (view.bounds.size.height * 0.25)  + 160, width: 50, height: 50)
            photoLibraryButton.setImage(#imageLiteral(resourceName: "photoLibrary"), for: .normal)
            photoLibraryButton.tintColor = .black
            photoLibraryButton.backgroundColor = Colors.green
            photoLibraryButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
            photoLibraryButton.addTarget(self, action: #selector(startHighlightLibrary), for: .touchDown)
            photoLibraryButton.addTarget(self, action: #selector(stopHighlightLibrary), for: .touchUpOutside)
            photoLibraryButton.addTarget(self, action: #selector(libraryButtonPressed), for: .touchUpInside)
}
    
    func setupCameraButton() {
        print("\(view.bounds.size.width)")
        print("\(view.frame.width)")
            cameraButton.frame = CGRect(x: (view.frame.size.width * 0.5) - (view.frame.width * 0.2) + 75, y: (view.bounds.size.height * 0.5)  - (view.bounds.size.height * 0.25)  + 160, width: 50, height: 50)
            cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
            cameraButton.tintColor = .black
            cameraButton.backgroundColor = Colors.green
            cameraButton.layer.cornerRadius = photoLibraryButton.bounds.size.width * 0.5
            cameraButton.addTarget(self, action: #selector(startHighlightCamera), for: .touchDown)
            cameraButton.addTarget(self, action: #selector(stopHighlightCamera), for: .touchUpOutside)
            cameraButton.addTarget(self, action: #selector(CameraButtonPressed), for: .touchUpInside)
    }
    
    func setupDismissButton() {
        dismissButton.setTitle("Dismiss", for: .normal)

        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.addTarget(self, action: #selector(startHighlightDismiss), for: .touchDown)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(stopHighlightDismiss), for: .touchUpOutside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        dismissButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        let _ = dismissButton.addBorders(edges: [.top, .right], color: Colors.softBlue)
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(startHighlightSave), for: .touchDown)
        saveButton.addTarget(self, action: #selector(stopHighlightSave), for: .touchUpOutside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        saveButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        let _ = saveButton.addBorders(edges: [.top, .left], color: Colors.softBlue)
    }
}

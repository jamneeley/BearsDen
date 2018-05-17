//
//  MyDenViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MyDenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let backGroundView = UIView()
    let newUserStackView = UIStackView()
    let promptLabel =  UILabel()
    let denImageView = UIImageView()
    let letsStartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupObjects()
    }

    
    func setupObjects() {
        setupBackGroundView()
        setupLetsStartButton()
        setupPromptLabel()
        setupDenImageView()
    }
    
    
    
    @objc func selectImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            denImageView.image = image
        } else {
            print("error picking image from imagepicker")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func letsStartButtonPressed() {
        guard let image = denImageView.image else {return}
        UserController.shared.add(Picture: image)
        let mainView = MainViewController()
        self.present(mainView, animated: true, completion: nil)
    }
}



////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension MyDenViewController {
    func setupBackGroundView() {
        view.addSubview(backGroundView)
        backGroundView.backgroundColor = Colors.softBlue
        setupBackGroundViewConstraints()
    }
    func setupPromptLabel() {
        view.addSubview(promptLabel)
        promptLabel.textAlignment = .center
        promptLabel.textColor = .black
        promptLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        promptLabel.text = "Would you like to add a picture of the people in your household? \nTouch the image below and select a picture, otherwise press \"lets Begin\"."
        promptLabel.numberOfLines = 0
        setupPromptLabelConstraints()
    }
    
    func setupDenImageView() {
        view.addSubview(denImageView)
        denImageView.isUserInteractionEnabled = true
        denImageView.clipsToBounds = true
        denImageView.layer.masksToBounds = false
        denImageView.layer.borderWidth = 2.0
        denImageView.layer.borderColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageTapped))
        singleTap.numberOfTapsRequired = 1
        denImageView.addGestureRecognizer(singleTap)
        denImageView.image = #imageLiteral(resourceName: "imagePlaceHolder")
        setupDenImageViewConstraints()
    }
    
    func setupLetsStartButton() {
        view.addSubview(letsStartButton)
        letsStartButton.frame = CGRect(x: view.frame.width * 0.5 - 32.5, y: view.frame.height * 0.88, width: 65, height: 65)
        letsStartButton.setTitle("Next", for: .normal)
        letsStartButton.setTitleColor(.white, for: .normal)
        letsStartButton.backgroundColor = Colors.green
        letsStartButton.layer.cornerRadius = 0.5 * letsStartButton.bounds.size.width
        letsStartButton.clipsToBounds = true
        letsStartButton.addTarget(self, action: #selector(letsStartButtonPressed), for: .touchUpInside)
    }
    
    func setupBackGroundViewConstraints() {
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupPromptLabelConstraints() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05).isActive = true
        promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.25).isActive = true
    }
    
    func  setupDenImageViewConstraints() {
        denImageView.translatesAutoresizingMaskIntoConstraints = false
        denImageView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: view.frame.height * 0.05).isActive = true
        denImageView.bottomAnchor.constraint(equalTo: letsStartButton.topAnchor, constant: view.frame.height * -0.05).isActive = true
        denImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        denImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width
            * -0.1).isActive = true
    }
}


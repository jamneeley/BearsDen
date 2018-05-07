//
//  NewUserViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/1/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class NewDenNameViewController: UIViewController {
    let backGroundView = UIView()
//    let logoView = UIImageView()
    let newUserStackView = UIStackView()
    let actionStackView = UIStackView()
    let promptLabel =  UILabel()
    let houseTextField = UITextField()
    let letsStartButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }

    func setupObjects() {
        setupBackGroundView()
        setupLetsStartButton()
        setupPromptLabel()
        setupHouseTextField()
        
    }
    
    func setupBackGroundView() {
        view.addSubview(backGroundView)
        backGroundView.backgroundColor = .white
        setupBackGroundViewConstraints()
    }
    
    func setupPromptLabel() {
        view.addSubview(promptLabel)
        promptLabel.textAlignment = .center
        promptLabel.textColor = Colors.darkPurple
        promptLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        promptLabel.text = "We're excited to help you get started on your food storage!\n\nlets start by naming your den."
        promptLabel.numberOfLines = 0
        setupPromptLabelConstraints()
    }
    
    func setupHouseTextField() {
        view.addSubview(houseTextField)
        houseTextField.backgroundColor = .white
        houseTextField.placeholder = "The Smiths den..."
        houseTextField.layer.cornerRadius = 12
        setupHouseTextFieldConstraints()
    }
    
    func setupLetsStartButton() {
        view.addSubview(letsStartButton)
        letsStartButton.setTitle("Next!", for: .normal)
        letsStartButton.setTitleColor(.white, for: .normal)
        letsStartButton.backgroundColor = Colors.softBlue
        letsStartButton.addTarget(self, action: #selector(letsStartButtonPressed), for: .touchUpInside)
        setupLetsStartButtonConstraints()
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
        promptLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.35).isActive = true
    }
    
    func setupHouseTextFieldConstraints() {
        houseTextField.translatesAutoresizingMaskIntoConstraints = false
        houseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        houseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        houseTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        houseTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.06).isActive = true
    }
    
    func setupNewUserViewConstraints() {
        newUserStackView.translatesAutoresizingMaskIntoConstraints = false
        newUserStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.3).isActive = true
        newUserStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width * 0.08)).isActive = true
        newUserStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.08)).isActive = true
        newUserStackView.bottomAnchor.constraint(equalTo: letsStartButton.topAnchor, constant: (view.frame.height * -0.35)).isActive = true
    }
    
    func setupLetsStartButtonConstraints() {
        letsStartButton.translatesAutoresizingMaskIntoConstraints = false
        letsStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        letsStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        letsStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        letsStartButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height * 0.43).isActive = true
    }
    
    @objc func letsStartButtonPressed() {
        guard let denName = houseTextField.text, !denName.isEmpty else {return}
        //save the den name and move on
//        UserController.shared.createUser(housHouldName: denName)
        let pictureView = DenPictureViewController()
        self.present(pictureView, animated: true, completion: nil)
    }
}

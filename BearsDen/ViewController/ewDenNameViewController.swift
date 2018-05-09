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
    let bearHillView = UIImageView()
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
        setupBearHillView()
        setupHouseTextField()
        setupPromptLabel()
        
    }
    
    func setupBackGroundView() {
        view.addSubview(backGroundView)
        backGroundView.backgroundColor = Colors.softBlue
        setupBackGroundViewConstraints()
    }
    
    func setupBearHillView() {
        view.addSubview(bearHillView)
        bearHillView.image = #imageLiteral(resourceName: "BearOnHill")
        setupBearHillViewConstraints()
    }
    
    func setupPromptLabel() {
        view.addSubview(promptLabel)
        promptLabel.textAlignment = .center
        promptLabel.textColor = .white
        promptLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        promptLabel.text = "We're excited to help you get started on your food storage!\n\nlets start by naming your den."
        promptLabel.numberOfLines = 0
        setupPromptLabelConstraints()
    }
    
    //FIXME: - Split up the label into two labels and change the font size of the two
    
    
    func setupHouseTextField() {
        view.addSubview(houseTextField)
        houseTextField.backgroundColor = .white
        houseTextField.placeholder = "The Smiths den..."
        houseTextField.layer.cornerRadius = 12
        setupHouseTextFieldConstraints()
    }
    

    
    func setupBearHillViewConstraints() {
        bearHillView.translatesAutoresizingMaskIntoConstraints = false
        bearHillView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05).isActive = true
        bearHillView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        bearHillView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        bearHillView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.55).isActive = true
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
        promptLabel.topAnchor.constraint(equalTo: bearHillView.bottomAnchor, constant: -25).isActive = true
        promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: houseTextField.topAnchor, constant: -30).isActive = true
    }
    
    func setupHouseTextFieldConstraints() {
        houseTextField.translatesAutoresizingMaskIntoConstraints = false
        houseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        houseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        houseTextField.bottomAnchor.constraint(equalTo: letsStartButton.topAnchor , constant: -30).isActive = true
        houseTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.06).isActive = true
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
    
    @objc func letsStartButtonPressed() {
        guard let denName = houseTextField.text, !denName.isEmpty else {return}
        UserController.shared.createUser(housHouldName: denName)
        let pictureView = DenPictureViewController()
        self.present(pictureView, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "isCurrentUser")
    }
}

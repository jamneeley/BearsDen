//
//  DenPictureViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class AddShelfInstructionsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let backGroundView = UIView()
    let denImageView = UIImageView()
    let promptLabel =  UILabel()
    let letsStartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    func setupObjects() {
        setupBackGroundView()
        setupLetsStartButton()
        setupPromptLabel()
        setupDenImageView()
    }
    
    @objc func letsStartButtonPressed() {
        let mainView = MainViewController()
        self.present(mainView, animated: true, completion: nil)
    }
}


////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension AddShelfInstructionsViewController {
    func setupBackGroundView() {
        view.addSubview(backGroundView)
        backGroundView.backgroundColor = Colors.softBlue
        setupBackGroundViewConstraints()
    }
    func setupPromptLabel() {
        view.addSubview(promptLabel)
        promptLabel.textAlignment = .center
        promptLabel.textColor = .white
        promptLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        promptLabel.text = "With Bears Den you can organize your food storage into shelves. Just click the + button to create a new shelf."
        promptLabel.numberOfLines = 0
        setupPromptLabelConstraints()
    }
    
    func setupDenImageView() {
        view.addSubview(denImageView)
        denImageView.clipsToBounds = true
        denImageView.layer.masksToBounds = false
        denImageView.image = #imageLiteral(resourceName: "AddShelfInstructions")
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
        promptLabel.bottomAnchor.constraint(equalTo: letsStartButton.topAnchor, constant: -30).isActive = true
        promptLabel.topAnchor.constraint(equalTo: letsStartButton.topAnchor , constant: -130).isActive = true
        promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1).isActive = true
        promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.1).isActive = true
        
    }
    
    func  setupDenImageViewConstraints() {
        denImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: denImageView, attribute: .height, relatedBy: .equal, toItem: denImageView, attribute: .width, multiplier: 1.0 / 0.6, constant: 0).isActive = true
        denImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        denImageView.bottomAnchor.constraint(equalTo: promptLabel.topAnchor, constant: -10).isActive = true
        denImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}


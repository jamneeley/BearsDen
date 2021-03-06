//
//  SecondLaunchScreenViewController.swift
//  BearsDen
//
//  Created by James Neeley on 4/20/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class SecondLaunchScreenViewController: UIViewController {
    
    let backGroundView = UIView()
    let logoView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGroundView()
        setupLogoImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isNewUser()
    }
    
    
    //check if this is the users first time opening the app
    func isNewUser() {
        if UserDefaults.standard.object(forKey: "isCurrentUser") as? Bool == true {
            print("existing user")
            segueToExistingUser()
            UserController.shared.loadFromCoreData()
        } else {
            print("new user")
            segueToNewUserView()
        }
    }
    
    func segueToExistingUser() {
        let mainView = MainViewController()
        self.present(mainView, animated: true, completion: nil)
    }
        
    func segueToNewUserView() {
        print("attempted to make new user")
        let newUser = NewDenNameViewController()
        self.present(newUser, animated: true, completion: nil)
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.logoView.frame.origin.y = -self.view.frame.height
        }) { (success) in
        }
    }

///////////////////////////
//MARK: - Views
///////////////////////////

    func setupBackGroundView() {
        view.addSubview(backGroundView)
        backGroundView.backgroundColor = Colors.softBlue
    
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupLogoImage() {
        view.addSubview(logoView)
        logoView.layer.cornerRadius = CornerRadius.imageView
        logoView.image = UIImage(named: "BearsDenLogo")
        logoView.contentMode = UIViewContentMode.scaleAspectFill
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: logoView, attribute: .height, relatedBy: .equal, toItem: logoView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        logoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200 ).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}



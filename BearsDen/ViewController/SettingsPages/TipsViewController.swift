//
//  TipsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    let testLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
    }

    func setupLabel() {
        view.addSubview(testLabel)
        testLabel.text = "Tips And Stuff"
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
}

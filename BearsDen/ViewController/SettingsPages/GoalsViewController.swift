//
//  GoalsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController {
    
    let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupLabel() {
        view.addSubview(testLabel)
        testLabel.text = "TESTING"
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        testLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

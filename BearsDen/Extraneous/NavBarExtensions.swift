//
//  NavBarExtensions.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

extension ShelvesViewController {
    
    func setupNavBar() {
        view.addSubview(navBar)
        navBar.backgroundColor = Colors.softBlue
        navBar.addSubview(settingsButton)
        navBar.addSubview(addButton)
        navBar.backgroundColor = Colors.softBlue
        navBar.addSubview(settingsButton)
        navBar.addSubview(addButton)
        navBar.addSubview(navBarLabel)
        setupButtons()
        setupLabel()
        setupNavBarConstraints()
        setupButtonConstraints()
    }
    
    func setupButtons() {
        settingsButton.tintColor = Colors.darkPurple
        settingsButton.setImage(#imageLiteral(resourceName: "settingIconX2"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        addButton.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        addButton.tintColor = Colors.darkPurple
        addButton.addTarget(self, action: #selector(addShelfButtonTapped), for: .touchUpInside)
    }
    
    func setupLabel() {
        navBarLabel.text = "Your Shelves"
        navBarLabel.font = UIFont.boldSystemFont(ofSize: 20)
        setupLabelConstraints()
    }
    
    func setupNavBarConstraints() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        navBar.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.08).isActive = true
    }
    
    func setupButtonConstraints() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 8).isActive = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        addButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
    }
    
    func setupLabelConstraints() {
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        navBarLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func settingsButtonTapped() {
        settingsLauncher.showSettings()
    }
    
    func showControllerFor(Setting setting: Setting) {
        let dummyViewController = UIViewController()
        //        dummyViewController.navigationItem.title = setting.name
        dummyViewController.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        //sets the navbar title text color....FIGURE OUT
        //        navigationController?.navigationBar.titleTextAttributes = .white
        navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
    @objc func addShelfButtonTapped() {
        let itemsTableView = ItemsViewController()
        //        let itemNavigationController = UINavigationController(rootViewController: itemsTableView)
        navigationController?.pushViewController(itemsTableView, animated: true)
        
    }

}

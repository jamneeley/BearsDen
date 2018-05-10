//
//  MainViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //non page dependent objects
    let navBar = UIView()
    let settingsButton = UIButton(type: UIButtonType.system)
    let navBarLabel = UILabel()
    
    //viewcontrollers
    lazy var shelvesView: ShelvesViewController = {
        return ShelvesViewController()
    }()
    lazy var goalsView: GoalsViewController = {
        return GoalsViewController()
    }()
    lazy var shoppingView: ShoppingListViewController = {
        return ShoppingListViewController()
    }()
    lazy var tipsView: TipsViewController = {
        return TipsViewController()
    }()
    lazy var myDenView: MyDenViewController = {
        return MyDenViewController()
    }()
    lazy var settingsview: SettingsViewController = {
        return SettingsViewController()
    }()

    //Page Dependent Button
    let shelvesAddButton = UIButton(type: UIButtonType.system)
    let goalsAddButton = UIButton(type: UIButtonType.system)
    let shoppingAddButton = UIButton(type: UIButtonType.system)
    
    // current page in containerView property
    var globalCurrentView: Int?
    
    // computed settings launcher....only fires code once
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.mainParentView = self
        return launcher
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    //MARK: - SetupObjects
    
    func setupObjects() {
        setupNavBar()
        setupShelvesView()
    }

    func setupNavBar() {
        view.addSubview(navBar)
        navBar.backgroundColor = Colors.softBlue
        navBar.tintColor = .white
        navBar.addSubview(settingsButton)
        navBar.addSubview(navBarLabel)
        navBar.addSubview(shelvesAddButton)
        setupLabel()
        setupNavBarConstraints()
        setupSettingsButtonConstraints()
        setupSettingsButtons()
        setupShelvesButton()
        setup(Button: goalsAddButton)
        setup(Button: shoppingAddButton)
        setupButtonTargets()
    }
    
    func setupSettingsButtons() {
        settingsButton.setImage(#imageLiteral(resourceName: "settingIconX2"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    func setupShelvesButton() {
        shelvesAddButton.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        shelvesAddButton.translatesAutoresizingMaskIntoConstraints = false
        shelvesAddButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        shelvesAddButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
    }
    
    func setup(Button button: UIButton) {
        button.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButtonTargets() {
        shelvesAddButton.addTarget(self, action: #selector(addShelfButtonTapped), for: .touchUpInside)
        goalsAddButton.addTarget(self, action: #selector(addGoalButtonTapped), for: .touchUpInside)
        shoppingAddButton.addTarget(self, action: #selector(addShoppingItemButtonTapped), for: .touchUpInside)
    }
    
    func setupLabel() {
        navBarLabel.text = "Your shelves"
        navBarLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navBarLabel.textColor = .white
        setupLabelConstraints()
    }
    
    func setupShelvesView() {
        shelvesView.willMove(toParentViewController: self)
        addChildViewController(shelvesView)
        self.view.addSubview(shelvesView.view)
        shelvesView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shelvesView.view.frame = CGRect(x: 0, y: view.frame.height * 0.08, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
        shelvesView.didMove(toParentViewController: self)
        globalCurrentView = 1
    }
    
    //MARK: - SetupConstraints
    
    func setupNavBarConstraints() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        navBar.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.08).isActive = true
    }
    
    func setupSettingsButtonConstraints() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 8).isActive = true
    }
    
    func setupLabelConstraints() {
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        navBarLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor, constant: 0).isActive = true
    }
    
    //MARK: - Button Actions
    
    @objc func settingsButtonTapped() {
        settingsLauncher.showSettings()
    }
    
    @objc func addShelfButtonTapped() {
        print("addShelfButton Pressed")
        let alert = UIAlertController(title: "New shelf name", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
        }
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { (success) in
            guard let shelfName = alert.textFields?.first?.text, !shelfName.isEmpty,
            let user = UserController.shared.user else {return}
            ShelfController.shared.createShelfForUser(User: user, name: shelfName)
            self.shelvesView.update = true
        }
        alert.addAction(dismiss)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func addGoalButtonTapped() {
        print("AddGoalButton Pressed")
    }
    
    @objc func addShoppingItemButtonTapped() {
        print("addShoppingItemButton Pressed")
    }
}


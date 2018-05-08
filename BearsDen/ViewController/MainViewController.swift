//
//  MainViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let navBar = UIView()
    let settingsButton = UIButton()
    let addButton = UIButton()
    let navBarLabel = UILabel()
    var globalCurrentView: Int?
    
    //viewcontrollers
    let shelvesView = ShelvesViewController()
    let goalsView = GoalsViewController()
    let shoppingView = ShoppingListViewController()
    let tipsView = TipsViewController()
    let settingsview = SettingsViewController()

    //buttons
    
    lazy var settingsLauncher: SettingsLauncher = {
        print("Settings Launcher \(globalCurrentView)")
        let launcher = SettingsLauncher()
        launcher.mainParentView = self
        launcher.currentView = globalCurrentView
        return launcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        
    }
    
    func setupObjects() {
        setupNavBar()
        setupShelvesView()
    }

    func setupNavBar() {
        view.addSubview(navBar)
        navBar.backgroundColor = Colors.softBlue
        navBar.addSubview(settingsButton)
        navBar.addSubview(navBarLabel)
        navBar.addSubview(addButton)
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
    
    func setupShelvesView() {
        shelvesView.willMove(toParentViewController: self)
        addChildViewController(shelvesView)
        self.view.addSubview(shelvesView.view)
        shelvesView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shelvesView.view.frame = CGRect(x: 0, y: view.frame.height * 0.08, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
        shelvesView.didMove(toParentViewController: self)
        globalCurrentView = 0
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
        print("Setting Button Tapped: \(globalCurrentView)")
        settingsLauncher.showSettings()
    }
    
    @objc func addShelfButtonTapped() {
        let itemsTableView = ItemsViewController()
        
        
    }
    
    func showControllerFor(Setting setting: Setting, currentView: Int) {
        if currentView == 0 {
            if setting.number == 1 {
                globalCurrentView = 1
                print("Changed Global number in show controller \(globalCurrentView)")
                changefrom(OldVC: shelvesView, newVC: goalsView)
            }
            if setting.number == 2 {
                globalCurrentView = 2
                changefrom(OldVC: shelvesView, newVC: shoppingView)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changefrom(OldVC: shelvesView, newVC: tipsView)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changefrom(OldVC: shelvesView, newVC: settingsview)
            }
        } else if currentView == 1 {
            if setting.number == 0 {
                globalCurrentView = 0
                changefrom(OldVC: goalsView, newVC: shelvesView)
            }
            if setting.number == 2 {
                globalCurrentView = 2
                changefrom(OldVC: goalsView, newVC: shoppingView)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changefrom(OldVC: goalsView, newVC: tipsView)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changefrom(OldVC: goalsView, newVC: settingsview)
            }
            
        } else if currentView == 2 {
            if setting.number == 1 {
                globalCurrentView = 1
                changefrom(OldVC: shoppingView, newVC: goalsView)
            }
            if setting.number == 0 {
                globalCurrentView = 0
                changefrom(OldVC: shoppingView, newVC: shelvesView)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changefrom(OldVC: shoppingView, newVC: tipsView)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changefrom(OldVC: shoppingView, newVC: settingsview)
            }
        } else if currentView == 3 {
            if setting.number == 1 {
                globalCurrentView = 1
                changefrom(OldVC: tipsView, newVC: goalsView)
            }
            if setting.number == 2 {
                globalCurrentView = 2
                changefrom(OldVC: tipsView, newVC: shoppingView)
            }
            if setting.number == 0 {
                globalCurrentView = 0
                changefrom(OldVC: tipsView, newVC: shelvesView)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changefrom(OldVC: tipsView, newVC: settingsview)
            }
        } else if currentView == 4 {
            if setting.number == 1 {
                globalCurrentView = 1
                changefrom(OldVC: settingsview, newVC: goalsView)
            }
            if setting.number == 2 {
                globalCurrentView = 2
                changefrom(OldVC: settingsview, newVC: shoppingView)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changefrom(OldVC: settingsview, newVC: tipsView)
            }
            if setting.number == 0 {
                globalCurrentView = 0
                changefrom(OldVC: settingsview, newVC: shelvesView)
            }
        } else {
            print("there was an error transitioning to a view")
        }
    }
    
    
    func changefrom(OldVC oldVC: UIViewController, newVC: UIViewController) {
        
        let newStartFrame = CGRect(x: 0 + self.view.frame.width, y: 0, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
        
        let newEndframe = CGRect(x: 0, y: view.frame.height * 0.08, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
        
        let oldfinishFrame = CGRect(x: 0 - self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    
    
        oldVC.willMove(toParentViewController: nil)
        self.addChildViewController(newVC)
        newVC.view.frame = newStartFrame
        
        transition(from: oldVC, to: newVC, duration: 0.2, options: [.curveEaseOut], animations: {
            oldVC.view.frame = oldfinishFrame
            newVC.view.frame = newEndframe
        }, completion: { (success) in
            oldVC.removeFromParentViewController()
            newVC.willMove(toParentViewController: self)
        })
    }
}


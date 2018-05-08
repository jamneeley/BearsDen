//
//  ContainerViewTransitions.swift
//  BearsDen
//
//  Created by James Neeley on 5/8/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
extension MainViewController {

    //MARK: - Show Page Based on setting button tapped
    
    func showControllerFor(Setting setting: Setting) {
        if globalCurrentView == 1 {
            if setting.number == 2 {
                globalCurrentView = 2
                changeVCfrom(OldVC: shelvesView, newVC: goalsView)
                change(OldButton: shelvesAddButton, newButton: goalsAddButton)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changeVCfrom(OldVC: shelvesView, newVC: shoppingView)
                change(OldButton: shelvesAddButton, newButton: shoppingAddButton)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changeVCfrom(OldVC: shelvesView, newVC: tipsView)
                remove(Button: shelvesAddButton)
            }
            if setting.number == 5 {
                globalCurrentView = 5
                changeVCfrom(OldVC: shelvesView, newVC: myDenView)
                remove(Button: shelvesAddButton)
            }
            if setting.number == 6 {
                globalCurrentView = 6
                changeVCfrom(OldVC: shelvesView, newVC: settingsview)
                remove(Button: shelvesAddButton)
            }
        } else if globalCurrentView == 2 {
            if setting.number == 1 {
                globalCurrentView = 1
                changeVCfrom(OldVC: goalsView, newVC: shelvesView)
                change(OldButton: goalsAddButton, newButton: shelvesAddButton)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changeVCfrom(OldVC: goalsView, newVC: shoppingView)
                change(OldButton: goalsAddButton, newButton: shoppingAddButton)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changeVCfrom(OldVC: goalsView, newVC: tipsView)
                remove(Button: goalsAddButton)
            }
            if setting.number == 5 {
                globalCurrentView = 5
                changeVCfrom(OldVC: goalsView, newVC: myDenView)
                remove(Button: goalsAddButton)
            }
            if setting.number == 6 {
                globalCurrentView = 6
                changeVCfrom(OldVC: goalsView, newVC: settingsview)
                remove(Button: goalsAddButton)
            }
        } else if globalCurrentView == 3 {
            if setting.number == 2 {
                globalCurrentView = 2
                changeVCfrom(OldVC: shoppingView, newVC: goalsView)
                change(OldButton: shoppingAddButton, newButton: goalsAddButton)
            }
            if setting.number == 1 {
                globalCurrentView = 1
                changeVCfrom(OldVC: shoppingView, newVC: shelvesView)
                change(OldButton: shoppingAddButton, newButton: shelvesAddButton)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changeVCfrom(OldVC: shoppingView, newVC: tipsView)
                remove(Button: shoppingAddButton)
            }
            if setting.number == 5 {
                globalCurrentView = 5
                changeVCfrom(OldVC: shoppingView, newVC: myDenView)
                remove(Button: shoppingAddButton)
            }
            if setting.number == 6 {
                globalCurrentView = 6
                changeVCfrom(OldVC: shoppingView, newVC: settingsview)
                remove(Button: shoppingAddButton)
            }
        } else if globalCurrentView == 4 {
            if setting.number == 2 {
                globalCurrentView = 2
                changeVCfrom(OldVC: tipsView, newVC: goalsView)
                add(Button: goalsAddButton)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changeVCfrom(OldVC: tipsView, newVC: shoppingView)
                add(Button: shoppingAddButton)
            }
            if setting.number == 1 {
                globalCurrentView = 1
                changeVCfrom(OldVC: tipsView, newVC: shelvesView)
                add(Button: shelvesAddButton)
            }
            if setting.number == 5 {
                globalCurrentView = 5
                changeVCfrom(OldVC: tipsView, newVC: myDenView)
            }
            if setting.number == 6 {
                globalCurrentView = 6
                changeVCfrom(OldVC: tipsView, newVC: settingsview)
            }
        } else if globalCurrentView == 5 {
            if setting.number == 2 {
                globalCurrentView = 2
                changeVCfrom(OldVC: myDenView, newVC: goalsView)
                add(Button: goalsAddButton)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changeVCfrom(OldVC: myDenView, newVC: shoppingView)
                add(Button: shoppingAddButton)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changeVCfrom(OldVC: myDenView, newVC: tipsView)
            }
            if setting.number == 1 {
                globalCurrentView = 1
                changeVCfrom(OldVC: myDenView, newVC: shelvesView)
                add(Button: shelvesAddButton)
            }
            if setting.number == 6 {
                globalCurrentView = 6
                changeVCfrom(OldVC: myDenView, newVC: settingsview)
            }
        } else if globalCurrentView == 6 {
            if setting.number == 2 {
                globalCurrentView = 2
                changeVCfrom(OldVC: settingsview, newVC: goalsView)
                add(Button: goalsAddButton)
            }
            if setting.number == 3 {
                globalCurrentView = 3
                changeVCfrom(OldVC: settingsview, newVC: shoppingView)
                add(Button: shoppingAddButton)
            }
            if setting.number == 4 {
                globalCurrentView = 4
                changeVCfrom(OldVC: settingsview, newVC: tipsView)
            }
            if setting.number == 5 {
                globalCurrentView = 5
                changeVCfrom(OldVC: settingsview, newVC: myDenView)
            }
            if setting.number == 1 {
                globalCurrentView = 1
                changeVCfrom(OldVC: settingsview, newVC: shelvesView)
                add(Button: shelvesAddButton)
            }
        } else {
            print("there was an error transitioning to a view")
        }
    }
    
    func changeVCfrom(OldVC oldVC: UIViewController, newVC: UIViewController) {
        
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
    
    //MARK: - Change button based on settings page tapped
    
    func change(OldButton oldButton: UIButton, newButton: UIButton) {
        oldButton.removeFromSuperview()
        navBar.addSubview(newButton)
        newButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        newButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
    }
    func remove(Button button: UIButton) {
        button.removeFromSuperview()
    }
    func add(Button button: UIButton) {
        navBar.addSubview(button)
        button.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        button.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
    }
}

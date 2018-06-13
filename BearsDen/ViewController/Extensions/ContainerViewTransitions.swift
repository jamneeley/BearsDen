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
    
    func showControllerFor(MenuItem item: MenuItem) {
        if globalCurrentView == 1 {
            switch item.number {
            case 1:
                print("switch to same view")
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: shelvesView, newVC: goalsView)
                change(OldButton: shelvesAddButton, newButton: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: shelvesView, newVC: shoppingView)
                change(OldButton: shelvesAddButton, newButton: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: shelvesView, newVC: calculatorView)
                remove(Button: shelvesAddButton)
                navBarLabel.text = "Calculator"
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: shelvesView, newVC: tipsView)
                remove(Button: shelvesAddButton)
                navBarLabel.text = "Tips"
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: shelvesView, newVC: myDenView)
                remove(Button: shelvesAddButton)
                navBarLabel.text = "My Den"
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: shelvesView, newVC: settingsview)
                remove(Button: shelvesAddButton)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 2 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: goalsView, newVC: shelvesView)
                change(OldButton: goalsAddButton, newButton: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                print("switch to same view")
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: goalsView, newVC: shoppingView)
                change(OldButton: goalsAddButton, newButton: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: goalsView, newVC: calculatorView)
                remove(Button: goalsAddButton)
                navBarLabel.text = "Calculator"
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: goalsView, newVC: tipsView)
                remove(Button: goalsAddButton)
                navBarLabel.text = "Tips"
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: goalsView, newVC: myDenView)
                remove(Button: goalsAddButton)
                navBarLabel.text = "My Den"
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: goalsView, newVC: settingsview)
                remove(Button: goalsAddButton)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 3 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: shoppingView, newVC: shelvesView)
                change(OldButton: shoppingAddButton, newButton: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: shoppingView, newVC: goalsView)
                change(OldButton: shoppingAddButton, newButton: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                print("switch to same view")
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: shoppingView, newVC: calculatorView)
                remove(Button: shoppingAddButton)
                navBarLabel.text = "Calculator"
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: shoppingView, newVC: tipsView)
                remove(Button: shoppingAddButton)
                navBarLabel.text = "Tips"
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: shoppingView, newVC: myDenView)
                remove(Button: shoppingAddButton)
                navBarLabel.text = "My Den"
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: shoppingView, newVC: settingsview)
                remove(Button: shoppingAddButton)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 4 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: calculatorView, newVC: shelvesView)
                add(Button: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: calculatorView, newVC: goalsView)
                add(Button: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: calculatorView, newVC: shoppingView)
                add(Button: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                print("switch to same view")
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: calculatorView, newVC: tipsView)
                navBarLabel.text = "Tips"
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: calculatorView, newVC: myDenView)
                navBarLabel.text = "My Den"
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: calculatorView, newVC: settingsview)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 5 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: tipsView, newVC: shelvesView)
                add(Button: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: tipsView, newVC: goalsView)
                add(Button: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: tipsView, newVC: shoppingView)
                add(Button: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: tipsView, newVC: calculatorView)
                navBarLabel.text = "Calculator"
            case 5:
                print("switch to same view")
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: tipsView, newVC: myDenView)
                navBarLabel.text = "My Den"
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: tipsView, newVC: settingsview)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 6 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: myDenView, newVC: shelvesView)
                add(Button: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: myDenView, newVC: goalsView)
                add(Button: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: myDenView, newVC: shoppingView)
                add(Button: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: myDenView, newVC: calculatorView)
                navBarLabel.text = "Calculator"
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: myDenView, newVC: tipsView)
                navBarLabel.text = "Tips"
            case 6:
                print("switch to same view")
            case 7:
                globalCurrentView = 7
                changeVCfrom(OldVC: myDenView, newVC: settingsview)
                navBarLabel.text = "Settings"
            default:
                print("something bad happened with the settings transition")
            }
        } else if globalCurrentView == 7 {
            switch item.number {
            case 1:
                globalCurrentView = 1
                changeVCfrom(OldVC: settingsview, newVC: shelvesView)
                add(Button: shelvesAddButton)
                navBarLabel.text = "Shelves"
            case 2:
                globalCurrentView = 2
                changeVCfrom(OldVC: settingsview, newVC: goalsView)
                add(Button: goalsAddButton)
                navBarLabel.text = "Goals"
            case 3:
                globalCurrentView = 3
                changeVCfrom(OldVC: settingsview, newVC: shoppingView)
                add(Button: shoppingAddButton)
                navBarLabel.text = "Shopping List"
            case 4:
                globalCurrentView = 4
                changeVCfrom(OldVC: settingsview, newVC: calculatorView)
                navBarLabel.text = "Calculator"
            case 5:
                globalCurrentView = 5
                changeVCfrom(OldVC: settingsview, newVC: tipsView)
                navBarLabel.text = "Tips"
            case 6:
                globalCurrentView = 6
                changeVCfrom(OldVC: settingsview, newVC: myDenView)
                navBarLabel.text = "My Den"
            case 7:
                print("switch to same view")
            default:
                print("something bad happened with the settings transition")
            }
        } else {
            print("Setting Number is messed up")
        }
    }
    
    func changeVCfrom(OldVC oldVC: UIViewController, newVC: UIViewController) {
        oldVC.deallocate()
        
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
            oldVC.willMove(toParentViewController: nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
            newVC.willMove(toParentViewController: self)
            
            self.view.addSubview(newVC.view)
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

extension UIViewController {
    func deallocate() {
    }
}

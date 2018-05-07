//
//  SettingsLauncher.swift
//  BearsDen
//
//  Created by James Neeley on 5/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    var shelvesView: ShelvesTableViewController?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    
    let settings: [Setting] = {
        
        let shelves = Setting(name: "Shelves", imageName: "settingsGear2x")
        let tips = Setting(name: "Tips", imageName: "settingsGear2x")
        let goals = Setting(name: "Goals", imageName: "settingsGear2x")
        let shoppingList = Setting(name: "Shopping List", imageName: "settingsGear2x")
        let settings = Setting(name: "Settings", imageName: "settingsGear2x")
        let terms = Setting(name: "terms", imageName: "settingsGear2x")
        let help = Setting(name: "help", imageName: "settingsGear2x")
        
        return [shelves, goals, shoppingList, tips, settings]
    }()
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let width = window.frame.width * 0.75
            let height = window.frame.height
            collectionView.frame = CGRect(x: -(window.frame.width), y: 0, width: width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (success) in
            //push the new view controller onto the nav stack....the navigation item should do this....not us!
            //            self.shelvesView?.pushViewController(**YourVIEWController**, animated: true)
            
            //im about to let the shelvesViewController know what setting the user selected and then the shelvesViewController is going to navigate to the right viewcontroller....however i want the navigationcontroller to know which item i selected and push the right view controller under the navcontroller and to the top of the nav stack so that the user will always have access to the side menu regardless of which view controller they are on. FIX ME LATER!!!!!
            
            
            if setting.name != "" && setting.name != "Goals" {
                // do something specific for whatever sections the user selects
                self.shelvesView?.showControllerFor(Setting: setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingsCollectionViewCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.07)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }

    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
}

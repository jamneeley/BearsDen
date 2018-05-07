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
    
    var shelvesView: ShelvesViewController?
    var goalsView: GoalsViewController?
    var shoppingListView: ShoppingListViewController?
    var tipsView: TipsViewController?
    var settingsView: SettingsViewController?
    
    
    let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .yellow
        return view
    }()

    let cellID = "cellID"
    let settings: [Setting] = {
        
        let shelves = Setting(name: "Shelves", imageName: "shelves2x")
        let tips = Setting(name: "Tips", imageName: "tips2x")
        let goals = Setting(name: "Goals", imageName: "checkMark2x")
        let shoppingList = Setting(name: "Shopping List", imageName: "shoppingCartX2")
        let settings = Setting(name: "Settings", imageName: "settingsGear2x")
        let terms = Setting(name: "terms", imageName: "settingsGear2x")
        let help = Setting(name: "help", imageName: "settingsGear2x")
        
        return [shelves, goals, shoppingList, tips, settings]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white

        return cv
    }()
    
    let denImage = UIImageView()
    let denNameLabel = UILabel()
    
    // VIEWDIDLOAD!!!!!
    
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
    }
    
    func setupObjects() {
        setupDenImageView()
        setupTestLabel()
        setupCollectionViewConstraints()

    }
    
    func setupDenImageView() {
        mainView.addSubview(denImage)
        denImage.clipsToBounds = true
        denImage.image = #imageLiteral(resourceName: "imagePlaceHolder")
        setupDenImageViewConstraints()
    }
    
    func setupTestLabel() {
        mainView.addSubview(denNameLabel)
        denNameLabel.text = "TEST"
        denNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        denNameLabel.textAlignment = .center
        setuptestLabelConstraints()
    }

    func setupDenImageViewConstraints() {
        mainView.addSubview(collectionView)
        denImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: denImage, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 200).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: denImage, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setuptestLabelConstraints() {
        denNameLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint(item: denNameLabel, attribute: .top, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .bottom, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 35).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: denNameLabel, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
    }
    
    //LOCAL FUNCTIONS
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(mainView)
//            mainView.addSubview(collectionView)
            let width = window.frame.width * 0.75
            let height = window.frame.height
          
            mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0

            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.mainView.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
            }, completion: nil)
        }
    }
    
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
            }
        }) { (success) in
            if setting.name == "Shelves" {
                // do something specific for whatever sections the user selects
                self.shelvesView?.showControllerFor(Setting: setting)
            }
            
            if setting.name ==  "Goals "{
                
            }
            
            if setting.name ==  "Shopping List "{
                
            }
            
            if setting.name ==  "Tips "{
                
            }
            
            if setting.name ==  "Settings "{
                
            }
        }
    }

    //COLLECTION VIEW FUNCTIONS
    
    
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
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
}

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
    let number: Int
    
    init(name: String, imageName: String, number: Int) {
        self.name = name
        self.imageName = imageName
        self.number = number
    }
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    
    var mainParentView: MainViewController?
    let shelvesView = ShelvesViewController()
    let goalsView = GoalsViewController()
    let shoppingView = ShoppingListViewController()
    let tipsView = TipsViewController()
    let settingsview = SettingsViewController()
 
    let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()

    let cellID = "cellID"
    let settings: [Setting] = {
        let shelves = Setting(name: "Shelves", imageName: "shelves2x", number: 0)
        let goals = Setting(name: "Goals", imageName: "checkMark2x", number: 1)
        let shoppingList = Setting(name: "Shopping List", imageName: "shoppingCartX2", number: 2)
        let tips = Setting(name: "Tips", imageName: "tips2x", number: 3)
        let myDen = Setting(name: "My Den", imageName: "bearsDenSideProfile", number: 4)
        let settings = Setting(name: "Settings", imageName: "settingsGear2x", number: 5)
        let terms = Setting(name: "terms", imageName: "settingsGear2x", number: 6)
        let help = Setting(name: "help", imageName: "settingsGear2x", number: 7)
        return [shelves, goals, shoppingList, tips, myDen, settings]
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
        setupDenLabel()
        setupCollectionViewConstraints()
    }
    
    func setupDenImageView() {
        mainView.addSubview(denImage)
        denImage.clipsToBounds = true
        denImage.image = #imageLiteral(resourceName: "imagePlaceHolder")
        setupDenImageViewConstraints()
    }
    
    func setupDenLabel() {
        mainView.addSubview(denNameLabel)
        denNameLabel.text = "TEST"
        denNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        denNameLabel.textAlignment = .center
        setupDenLabelConstraints()
    }

    func setupDenImageViewConstraints() {
        denImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: denImage, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 200).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: denImage, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setupDenLabelConstraints() {
        denNameLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint(item: denNameLabel, attribute: .top, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .bottom, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 35).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint(item: denNameLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setupCollectionViewConstraints() {
        mainView.addSubview(collectionView)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if let window = UIApplication.shared.keyWindow {
            collectionView.frame = CGRect(x: -(window.frame.width), y: 235, width: window.frame.width * 0.75, height: window.frame.height - 235)
        }
    }
    
    //LOCAL FUNCTIONS

    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(mainView)

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
                self.collectionView.frame = CGRect(x: 0, y: 235, width: window.frame.width * 0.75, height: window.frame.height - 235)
            }, completion: nil)
        }
    }
    
    
    @objc func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
                self.collectionView.frame = CGRect(x: -(window.frame.width), y: 235, width: window.frame.width * 0.75, height: window.frame.height - 235)
            }
        }) { (success) in
            guard let parent = self.mainParentView else {return}
            if setting.name != "" {
                parent.showControllerFor(Setting: setting)
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

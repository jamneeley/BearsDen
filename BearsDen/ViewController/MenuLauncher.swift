//
//  SettingsLauncher.swift
//  BearsDen
//
//  Created by James Neeley on 5/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    let name: String
    let imageName: String
    let number: Int
    
    init(name: String, imageName: String, number: Int) {
        self.name = name
        self.imageName = imageName
        self.number = number
    }
}

class MenuLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK - Properties
    
    var mainParentView: MainViewController?
    let blackView = UIView()
    let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    let denImage = UIImageView()
    let denNameLabel = UILabel()
    let seperator = UIView()
    let collectionViewYPosition = CGFloat(300)
    
    //MARK - Settings
    
    let cellID = "cellID"
    let menuItem: [MenuItem] = {
        let shelves = MenuItem(name: "Shelves", imageName: "shelves2x", number: 1)
        let goals = MenuItem(name: "Goals", imageName: "checkMark2x", number: 2)
        let shoppingList = MenuItem(name: "Shopping List", imageName: "shoppingCartX2", number: 3)
        let calculator = MenuItem(name: "Calculator", imageName: "calculatorButton", number: 4)
        let tips = MenuItem(name: "Tips", imageName: "tips2x", number: 5)
        let myDen = MenuItem(name: "My Den", imageName: "bearsDenSideProfile", number: 6)
        let settings = MenuItem(name: "Settings", imageName: "settingsGear2x", number: 7)
        return [shelves, goals, shoppingList, calculator, tips, myDen, settings]
    }()
    
    //MARK - LifeCycle
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
    }
    
    //MARK - setupViews
    
    func setupObjects() {
        setupDenImageView()
        setupDenLabel()
        setupSeperator()
        setupCollectionViewConstraints()
    }
    func checkDen() {
        setupDenImageView()
        setupDenLabel()
    }
    

    //MARK - Methods
    
    func showMenu() {
        checkDen()
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
            window.addSubview(blackView)
            window.addSubview(mainView)
            
            let width = window.frame.width * 0.75
            let height = window.frame.height
            
            mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.mainView.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
                self.collectionView.frame = CGRect(x: 0, y: self.collectionViewYPosition, width: window.frame.width * 0.75, height: window.frame.height - self.collectionViewYPosition)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(MenuItem: MenuItem) {
        //FIXME: Crash when touching blackview
        guard let parent = self.mainParentView else {return}
        parent.showControllerFor(MenuItem: MenuItem)
        
        UIView.animate(withDuration: 0.5, delay: 0.03, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
                self.collectionView.frame = CGRect(x: -(window.frame.width), y: self.collectionViewYPosition, width: window.frame.width * 0.75, height: window.frame.height - self.collectionViewYPosition)
            }
        }) { (success) in
        }
    }
    
    @objc func handleTapDismiss(setting: MenuItem) {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0
                self.mainView.frame = CGRect(x: -(window.frame.width), y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
                self.collectionView.frame = CGRect(x: -(window.frame.width), y: self.collectionViewYPosition, width: window.frame.width * 0.75, height: window.frame.height - self.collectionViewYPosition)
            }) { (success) in
            }
        }
    }

    //MARK - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingsCollectionViewCell
        let item = self.menuItem[indexPath.item]
        cell.setting = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.07)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = self.menuItem[indexPath.item]
        handleDismiss(MenuItem: menuItem)
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension MenuLauncher {
    
    func setupDenImageView() {
        mainView.addSubview(denImage)
        denImage.clipsToBounds = true
        guard let data = UserController.shared.user?.picture else {return}
        let denImageFromData = UIImage(data: data)
        denImage.layer.cornerRadius = CornerRadius.imageView
        denImage.image = denImageFromData
        setupDenImageViewConstraints()
    }
    
    func setupDenLabel() {
        mainView.addSubview(denNameLabel)
        guard let name = UserController.shared.user?.houseHoldName else {return}
        denNameLabel.text = "\(name)"
        denNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        denNameLabel.textAlignment = .center
        setupDenLabelConstraints()
    }
    
    func setupSeperator() {
        mainView.addSubview(seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        setupSeperatorConstraints()
    }
    
    func setupCollectionViewConstraints() {
        mainView.addSubview(collectionView)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if let window = UIApplication.shared.keyWindow {
            collectionView.frame = CGRect(x: -(window.frame.width), y: collectionViewYPosition, width: window.frame.width * 0.75, height: window.frame.height - collectionViewYPosition)
        }
    }
    
    func setupDenImageViewConstraints() {
        denImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: denImage, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 240).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .height, relatedBy: .equal, toItem: denImage, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: denImage, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setupDenLabelConstraints() {
        denNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: denNameLabel, attribute: .top, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint(item: denNameLabel, attribute: .bottom, relatedBy: .equal, toItem: denImage, attribute: .bottom, multiplier: 1.0, constant: 35).isActive = true
        NSLayoutConstraint(item: denNameLabel, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: denNameLabel, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setupSeperatorConstraints() {
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.topAnchor.constraint(equalTo: denNameLabel.bottomAnchor, constant: 5).isActive = true
        seperator.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        seperator.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
        seperator.bottomAnchor.constraint(equalTo: denNameLabel.bottomAnchor, constant: 7).isActive = true
    }
}

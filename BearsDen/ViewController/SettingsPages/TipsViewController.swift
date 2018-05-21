//
//  TipsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .yellow
        return cv
    }()
    
    let cellID = "tipsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func setupObjects() {
        setupCollectionView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("section count: \(TipsController.shared.tips.count)")
        return TipsController.shared.tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items in section: \(TipsController.shared.tips[section].count)")
        return TipsController.shared.tips[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell \([indexPath.section], [indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.07)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TipsCollectionViewCell
        print("cellforitemat: \(TipsController.shared.tips[indexPath.section][indexPath.row])")
        let tip = TipsController.shared.tips[indexPath.section][indexPath.row]
        print(tip)
        cell.tip = tip
        return cell
    }

}


////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension TipsViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

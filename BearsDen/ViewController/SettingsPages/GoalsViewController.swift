//
//  GoalsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalsSectionHeader: UICollectionReusableView {
    
    let sectionHeaderLabel = UILabel()
    var sectionHeader: String? {
        didSet{
            updateHeader()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionHeaderLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: sectionHeaderLabel)
        addConstraintsWithFormat(format: "V:|-\(frame.size.height * 0.3)-[v0]", views: sectionHeaderLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func updateHeader() {
        guard let sectionHeader = sectionHeader else {return}
        sectionHeaderLabel.text = sectionHeader
    }
}

class GoalsViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "goalCell"
    let header = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(GoalsSectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header)
        setupObjects()
    }
    
    func setupObjects() {
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header, for: indexPath) as? GoalsSectionHeader {
            sectionHeader.backgroundColor = .white
            sectionHeader.sectionHeader = TipsController.shared.sectionHeaders[indexPath.section]
            sectionHeader.sectionHeaderLabel.textAlignment = .left
            sectionHeader.sectionHeaderLabel.numberOfLines = 0
            sectionHeader.sectionHeaderLabel.font = UIFont.boldSystemFont(ofSize: 22)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: view.frame.height * 0.7)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TipsController.shared.tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TipsController.shared.tips[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goal = GoalController.shared.fakeGoal
        let goalDetailVC = GoalDetailViewController()
        goalDetailVC.goal = goal
        let navController = UINavigationController(rootViewController: goalDetailVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GoalsCollectionViewCell
        let tip = TipsController.shared.tips[indexPath.section][indexPath.row]
        cell.tip = tip
        cell.layer.cornerRadius = 12
        return cell
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension GoalsViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}








// BASIC FOOD STORAGE RECOMMENDATIONS
/*                      Adult/Week                          Kid/Week
 Grains                 7.692 lbs                           4.9998 lbs
 Legumes                1.154 lbs                           .7501  lbs
 Dairy Products         .576  lbs                           .3744  lbs
 Sugars                 1.154 lbs                           .7501  lbs
 Leavening Agents       .115  lbs                           .0748  lbs
 Salt                   .115  lbs                           .0748  lbs
 Fats                   .577  lbs                           .3750  lbs
 Water                  14    Gallons                       14 Gallons
 
 
 */

//Grain (includes wheat, white rice, oats, corn, barley, pasta, etc.):
//Legumes (dried beans, split peas, lentils, nuts, etc.):
//Dairy Products (powdered milk, cheese powdercheese powder, canned cheese, etc.):
//Sugars (white sugar, brown sugar, syrup, molasses, honey, etc.):
//Leavening Agents (Yeast, baking powder, powdered eggs, etc.):
//Salt (Table salt, sea salt, soy sauce, bouillon, etc.):
//Fats (Vegetable oils, shortening, canned butter, etc.):

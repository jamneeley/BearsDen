//
//  DenPictureViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

struct WelcomeToBearsDenInstructionsDataSource {
    static let instructions: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.8"), directions: "If you ever need help just tap the menu, go to \"Settings\" and go through the Tutorial")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.1"), directions: "To start inventorying your food storage just tap the + button to add a shelf.")
        let test3 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "We're happy and excited to help with your food storage! :)")
        return [test1, test2, test3]
    }()
}

class WelcomeToBearsDenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WelcomeToBearsDenCollectionViewCellDelegate {

    let cellID = "pageCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = Colors.white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WelcomeToBearsDenCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func setupObjects() {
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WelcomeToBearsDenCollectionViewCell
        let instruction = WelcomeToBearsDenInstructionsDataSource.instructions[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.pageNumber = 0
            cell.instruction = instruction
        case 1:
            cell.pageNumber = 1
            cell.instruction = instruction
        case 2:
            cell.pageNumber = 2
            cell.instruction = instruction
            cell.delegate = self
        default:
            print("something bad happened witht he welcome page collectionview")
        }
        cell.layer.cornerRadius = CornerRadius.textField
        
        return cell
    }
    
    func nextButtonPressed() {
        print("next button delegate works")
        let mainViewController = MainViewController()
        self.present(mainViewController, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "isCurrentUser")
    }
    
///////////////////////////
//View Properties
///////////////////////////
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}


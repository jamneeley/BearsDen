//
//  tutorialOneViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit



class TutorialDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var pageNumber: Int? {
        didSet {
            print("pageNumber set")
        }
    }
    
    let cellID = "pageCell"
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = Colors.veryLightGray
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TutorialDetailCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
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
        if let pageNumber = pageNumber {
            switch pageNumber {
            case 0:
                return TutorialDataSource.instructionZero.count
            case 1:
                return TutorialDataSource.instructionOne.count
            case 2:
                return TutorialDataSource.instructionTwo.count
            case 3:
                return TutorialDataSource.instructionThree.count
            case 4:
                return TutorialDataSource.instructionFour.count
            case 5:
                return TutorialDataSource.instructionFive.count
            case 6:
                return TutorialDataSource.instructionSix.count
            case 7:
                return TutorialDataSource.instructionSeven.count
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TutorialDetailCollectionViewCell
        cell.layer.cornerRadius = CornerRadius.textField
        if let pageNumber = pageNumber {
            switch pageNumber {
            case 0:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 1:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 2:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 3:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 4:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 5:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 6:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            case 7:
                let instruction = TutorialDataSource.instructionZero[indexPath.row]
                cell.instruction = instruction
            default:
                print("uh oh, something went wrong with the tutorialOneViewController cellForRowAt")
            }
        }

        return cell
    }
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}


struct TutorialDataSource {
    
    /*
  
 */
    
    //OverView of everything
    static let instructionZero: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    //Adding shelf/item
    static let instructionOne: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    //How goals work
    static let instructionTwo: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    //how to add a shopping list item
    static let instructionThree: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    //Calculator?
    static let instructionFour: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    
    //tips and my den
    static let instructionFive: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    
    static let instructionSix: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    //Whats in the settings?
    static let instructionSeven: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "TrashIcon"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test2 = Instruction(image: #imageLiteral(resourceName: "backX2"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test3 = Instruction(image: #imageLiteral(resourceName: "camera"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS  THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test4 = Instruction(image: #imageLiteral(resourceName: "checkedBox"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test5 = Instruction(image: #imageLiteral(resourceName: "flashOn"), directions: "THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS ESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE THIS IS A TESTER MESSAGE ")
        let test6 = Instruction(image: #imageLiteral(resourceName: "BearOnHill"), directions: "THIS ")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    
}


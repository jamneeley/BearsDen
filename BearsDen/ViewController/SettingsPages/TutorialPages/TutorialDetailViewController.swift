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
        cv.backgroundColor = Colors.white
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
                let instruction = TutorialDataSource.instructionOne[indexPath.row]
                cell.instruction = instruction
            case 2:
                let instruction = TutorialDataSource.instructionTwo[indexPath.row]
                cell.instruction = instruction
            case 3:
                let instruction = TutorialDataSource.instructionThree[indexPath.row]
                cell.instruction = instruction
            case 4:
                let instruction = TutorialDataSource.instructionFour[indexPath.row]
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
    
    //Menu Items
    static let instructionZero: [Instruction] = {
        
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.2"), directions: "\"Shelves\" is where all of your shelves and items are store. You can  customize each of your shelves and add items manually or with a barcode scanner to those shelves.")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.3"), directions: "\"Goals\" help you track your progress so you know how close your family is to complete self reliance.")
        let test3 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.4"), directions: "\"Shopping List\" add a shopping item either at your shelves item list or by tapping the + button at the top of the \"Shopping List\" page. this allows you to know what to grab next time you're at the store.")
        let test4 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.5"), directions: "\"Calculator\" can give you an idea of how much you need for a basic food storage for a certain period of time.")
        let test5 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.6"), directions: "\"Tips\" is a list of tips we have for your food storage and self-reliance needs.")
        let test6 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.7"), directions: "\"My Den\" shows you exactly how much of each category you have.")
        let test7 = Instruction(image: #imageLiteral(resourceName: "onBoarding1.8"), directions: "\"Settings\" is where you can change your Den info and if you like the app you can donate to the developer or rate our app.")

        return [test1, test2, test3, test4, test5, test6, test7]
        
    }()
    //Adding shelf/item
    static let instructionOne: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.1"), directions: "To add a shelf to your den, just tap the + button to show the \"Add shelf\" window. To go into your shelf, just tap on the shelf.")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.2"), directions: "The \"Add shelf\" window looks like this. Enter the shelfs name and choose your shelf picture from you photo libray with the lef button or transition to your camera by tapping the right button.")
        let test3 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.3"), directions: "If you want to edit the name or picure of a shelf, just tap on the edit button inside the shelf.")
        let test4 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.4"), directions: "To add an item to your shelf, you can tap either of the green buttons. The left button allows you to manually enter an item. the right button lets you scan an item and see if it exists in our database.")
        let test5 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.5"), directions: "When you are adding an item manually you will have to fill out \"Name\", \"Quantity\", and \"Weight\" text fields. You can also set the items Weight-Unit, Categoy, Barcode, and its Expiration Date.")
        let test6 = Instruction(image: #imageLiteral(resourceName: "onBoarding2.6"), directions: "when you scan a barcode, make sure the barcode is inside the white animating box. if the item doesnt exist it will bring you to the page to add the item manually.")
        
        return [test1, test2, test3, test4, test5, test6]
    }()
    
    //How goals work
    static let instructionTwo: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.6"), directions: "Goals will keep track of your food storage amounts. In order for your goal progress to be accurate, make sure when adding an item you enter its correct weight and category.")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.1"), directions: "To add an goal tap the + button.")
        let test3 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.2"), directions: "You'll need to enter a name for your goal and a date you would like the goal to be completed by.")
        let test4 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.4"), directions: "if you want a goal that involves fruit just tap the switch next to \"Fruit\", you can add any amount of category to your goal.")
        let test5 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.5"), directions: "when you've tapped the categories you want, make sure yo enter in an amount and unit. if you've included a custom goal just add a description to the text field.")
        let test6 = Instruction(image: #imageLiteral(resourceName: "onBoarding3.3"), directions: "When you want to save the goal, just tap \"Save\".")
        return [test1, test2, test3, test4, test5, test6]
    }()
    
    //how to add a shopping list item
    static let instructionThree: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding4.1"), directions: "You can add an item to your shopping list by tapping the yellow shopping cart inside any of your shelves.")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding4.3"), directions: "You can also add an item by tapping the + in your shopping list, just make sure to \"Save\" it.")
        let test3 = Instruction(image: #imageLiteral(resourceName: "onBoarding4.2"), directions: "To mark an item as purchased, just tap the box.")
        let test4 = Instruction(image: #imageLiteral(resourceName: "onBoarding4.4"), directions: "To delete an item from your list just slide left with your finger on the item you want to delete.")
        return [test1, test2, test3, test4]
    }()
    
    //Calculator?
    static let instructionFour: [Instruction] = {
        let test1 = Instruction(image: #imageLiteral(resourceName: "onBoarding5.1"), directions: "In order to calculate a basic food storage for your family, you'll need to add the number of adults and kids in your household in the settings.")
        let test2 = Instruction(image: #imageLiteral(resourceName: "onBoarding5.2"), directions: "Add the number of weeks your wanting to calculate for")
        let test3 = Instruction(image: #imageLiteral(resourceName: "onBoarding5.3"), directions: "Once your household size and number of weeks you want to calculate for, just tap the green calculator button.")
        return [test1, test2, test3]
    }()
}


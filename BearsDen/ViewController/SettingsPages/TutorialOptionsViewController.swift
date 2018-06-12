//
//  TutotialViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

struct tutorialOptionsDataSource {
    static let items: [String] = ["Adding a shelf", "Adding an item to a shelf", "How goals work", "how to add a shopping list item", "Calculator?", "Tips", "My Den?", "Whats in the settings?"]
}

class TutorialOptionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.veryLightGray
        return cv
    }()
    
    let cellID = "tutorialCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.veryLightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TutorialCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    func setupObjects() {
        setupNavigationBar()
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Tutorial"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = Colors.softBlue
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorialOptionsDataSource.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height * 0.15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TutorialCollectionViewCell
        cell.layer.cornerRadius = CornerRadius.textField
        cell.tutorialName = tutorialOptionsDataSource.items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tutorialVC = TutorialDetailViewController()
        
        switch indexPath.row {
        case 0:
            print("Adding a shelf")
            tutorialVC.pageNumber = 0
        case 1:
            print("Adding an item to a shelf")
            tutorialVC.pageNumber = 1
        case 2:
            print("How goals work")
            tutorialVC.pageNumber = 2
        case 3:
            print("how to add a shopping list item")
            tutorialVC.pageNumber = 3
        case 4:
            print("Calculator?")
            tutorialVC.pageNumber = 4
        case 5:
            print("Tips")
            tutorialVC.pageNumber = 5
        case 6:
            print("My Den?")
            tutorialVC.pageNumber = 6
        case 7:
            print("Whats in the settings?")
            tutorialVC.pageNumber = 7
        default:
            print("uh oh something went wrong with the tutorial didSelectItemAt method")
        }
        navigationController?.pushViewController(tutorialVC, animated: true)
    }

    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

//
//  ShelvesTableViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
//MARK: - Delegate Protocol

protocol shelvesViewControllerDelegate: class {
    func didSelectCellAtRow(shelf: Shelf)
}

class ShelvesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ShelfCollectionViewCellDelegate {

    //MARK: - Properties
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.veryLightGray
        return cv
    }()
    
    weak var delegate: shelvesViewControllerDelegate?
    
    var update: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: -  LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShelfCollectionViewCell.self, forCellWithReuseIdentifier: "shelfCell")
        setupCollectionViewConstraints()
    }
    
    //MARK: - Custom Methods
    
    func deleteShelf(shelf: Shelf) {
        let alert = UIAlertController(title: "Are you sure you want to delete \(shelf.name ?? "your shelf?")", message: nil, preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default) { (success) in
            ShelfController.shared.delete(Shelf: shelf)
            self.collectionView.reloadData()
        }
        alert.addAction(no)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - CollectionView DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserController.shared.user?.shelves?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 15, height: view.frame.height * 0.2)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shelfCell", for: indexPath) as! ShelfCollectionViewCell
        if let shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf {
            cell.shelf = shelf
            cell.delegate = self
            cell.dropShadow()
            cell.layer.cornerRadius = CornerRadius.textField
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let shelf: Shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf else {return}
        delegate?.didSelectCellAtRow(shelf: shelf)
    }


////////////////////////////////////////////////////////
//MARK: - Views
////////////////////////////////////////////////////////
    
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05 - 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05 + 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}







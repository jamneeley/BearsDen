//
//  ShelvesTableViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

protocol shelvesViewControllerDelegate: class {
    func didSelectCellAtRow(shelf: Shelf)
}

class ShelvesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ShelfCollectionViewCellDelegate {

    

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 25
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShelfCollectionViewCell.self, forCellWithReuseIdentifier: "shelfCell")
        setupObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
    func setupObjects() {
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserController.shared.user?.shelves?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.height * 0.2)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shelfCell", for: indexPath) as! ShelfCollectionViewCell
        if let shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf {
            cell.shelf = shelf
            cell.delegate = self
            cell.layer.cornerRadius = CornerRadius.textField
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            guard let shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf else {return}
//            ShelfController.shared.delete(Shelf: shelf)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let shelf: Shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf else {return}
        delegate?.didSelectCellAtRow(shelf: shelf)
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension ShelvesViewController {
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

/*
 
 
 //// COLLECTION VIEW
 func buildCollectionView() {
 let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 layout.scrollDirection = .horizontal
 layout.minimumInteritemSpacing = 0;
 layout.minimumLineSpacing = 4;
 
 collectionView = UICollectionView(frame: CGRect(x: 0, y: screenSize.midY - 120, width: screenSize.width, height: 180), collectionViewLayout: layout)
 
 collectionView.dataSource = self
 collectionView.delegate = self
 collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
 collectionView.showsHorizontalScrollIndicator = false
 collectionView.showsVerticalScrollIndicator = false
 collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 30)
 collectionView.backgroundColor = UIColor.white()
 collectionView.alpha = 0.0
 
 
 //can swipe cells outside collectionview region
 collectionView.layer.masksToBounds = false
 
 
 swipeUpRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.deleteCell))
 swipeUpRecognizer.delegate = self
 
 collectionView.addGestureRecognizer(swipeUpRecognizer)
 collectionView.isUserInteractionEnabled = true
 }
 
 /////CELL
 class VideoCell : UICollectionViewCell {
 var deleteView: UIButton!
 var imageView: UIImageView!
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 
 deleteView = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
 deleteView.contentMode = UIViewContentMode.scaleAspectFit
 contentView.addSubview(deleteView)
 
 imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
 imageView.contentMode = UIViewContentMode.scaleAspectFit
 contentView.addSubview(imageView)
 
 
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 
 ////////////////LOGIC
 func deleteCell(sender: UIPanGestureRecognizer) {
 let tapLocation = sender.location(in: self.collectionView)
 let indexPath = self.collectionView.indexPathForItem(at: tapLocation)
 
 if velocity.y < 0 {
 //detect if there is a swipe up and detect it's distance. If the distance is far enough we snap the cells Imageview to the top otherwise we drop it back down. This works fine already.
 }
 }
 
 
 
 
 ///// answer
 
 
 let cellFrame = activeCell.frame
 let rect = CGRectMake(cellFrame.origin.x, cellFrame.origin.y - cellFrame.height, cellFrame.width, cellFrame.height*2)
 if CGRectContainsPoint(rect, point) {
 // If swipe point is in the cell delete it
 
 let indexPath = myView.indexPathForCell(activeCell)
 cats.removeAtIndex(indexPath!.row)
 myView.deleteItemsAtIndexPaths([indexPath!])
 
 }

 
 
 
 
 */








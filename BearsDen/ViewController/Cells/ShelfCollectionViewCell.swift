//
//  ShelfTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

//MARK: - Delegate Protocol

protocol ShelfCollectionViewCellDelegate: class {
    func deleteShelf(shelf: Shelf)
}

class ShelfCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: ShelfCollectionViewCellDelegate?
    
    var shelf: Shelf? {
        didSet {
            setupViews()
        }
    }
    
    let shelfImageView = UIImageView()
    let ShelfNameLabel = UILabel()
    let itemCountLabel = UILabel()
    let deleteButton = UIButton()

    //MARK: - Cell initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Button Methods

    @objc func deleteButtonTapped() {
        guard let shelf = shelf else {return}
        delegate?.deleteShelf(shelf: shelf)
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? Colors.softBlue : .white
        }
    }
    
////////////////////////////////////////////////////////
//MARK: - Views
////////////////////////////////////////////////////////
    
    func setupViews() {
        backgroundColor = .white
        guard let shelf = shelf, let imageAsData = shelf.photo else {return}
        let photo = UIImage(data: imageAsData)
        shelfImageView.image = photo ?? #imageLiteral(resourceName: "imagePlaceHolder")
        itemCountLabel.text = "\(shelf.items?.count ?? 0) Items"
        ShelfNameLabel.text = shelf.name
        setupDeleteButton()
        setupShelfImageView()
        setupNameLabels()
    }
    func setupDeleteButton() {
        addSubview(deleteButton)
        deleteButton.setImage(#imageLiteral(resourceName: "TrashIcon"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        addConstraintsWithFormat(format: "H:|-3-[v0(20)]", views: deleteButton)
        addConstraintsWithFormat(format: "V:|-3-[v0(20)]", views: deleteButton)
    }
    
    func setupShelfImageView() {
        addSubview(shelfImageView)
        shelfImageView.layer.masksToBounds = true
        shelfImageView.layer.cornerRadius = CornerRadius.imageView
        addConstraintsWithFormat(format: "H:|-20-[v0(\(frame.height * 0.75))]", views: shelfImageView)
        addConstraintsWithFormat(format: "V:[v0(\(frame.height * 0.75))]", views: shelfImageView)
        shelfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupNameLabels() {
        addSubview(ShelfNameLabel)
        addSubview(itemCountLabel)
        ShelfNameLabel.numberOfLines = 3
        itemCountLabel.textColor = .lightGray
        itemCountLabel.font = UIFont.boldSystemFont(ofSize: 12)
        addConstraintsWithFormat(format: "H:|-\(frame.height * 0.96)-[v0(\(frame.width * 0.63))]", views: ShelfNameLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: itemCountLabel)
        addConstraintsWithFormat(format: "V:|-15-[v0]-65-|", views: ShelfNameLabel)
        itemCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}

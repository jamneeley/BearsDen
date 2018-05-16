//
//  ShelfTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShelfTableViewCell: UITableViewCell {
    
    var shelf: Shelf? {
        didSet {
            setupViews()
        }
    }
    
    let shelfImageView = UIImageView()
    let ShelfNameLabel = UILabel()
    let itemCountLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addSubview(shelfImageView)
        addSubview(ShelfNameLabel)
        addSubview(itemCountLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(100)]-10-[v1]-[v2]-10-|", views: shelfImageView, ShelfNameLabel, itemCountLabel)
        addConstraintsWithFormat(format: "V:|-50-[v0]-50-|", views: ShelfNameLabel)
        addConstraintsWithFormat(format: "V:|-50-[v0]-50-|", views: itemCountLabel)
        addConstraintsWithFormat(format: "V:[v0(100)]", views: shelfImageView)
        shelfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupViews() {
        guard let shelf = shelf, let imageAsData = shelf.photo else {return}
        let photo = UIImage(data: imageAsData)
        backgroundColor = .white
        shelfImageView.image = photo ?? #imageLiteral(resourceName: "imagePlaceHolder")
        ShelfNameLabel.text = shelf.name
        itemCountLabel.text = "\(shelf.items?.count ?? 0) Items"
        shelfImageView.layer.cornerRadius = shelfImageView.bounds.size.width * 0.5 
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? Colors.softBlue : .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

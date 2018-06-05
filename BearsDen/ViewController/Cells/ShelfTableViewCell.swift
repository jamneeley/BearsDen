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
        addSubview(shelfImageView)
        addSubview(ShelfNameLabel)
        addSubview(itemCountLabel)
        ShelfNameLabel.numberOfLines = 3
        addConstraintsWithFormat(format: "H:|-8-[v0(80)]-10-[v1]-80-|", views: shelfImageView, ShelfNameLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: itemCountLabel)
        ShelfNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ShelfNameLabel.centerYAnchor.constraint(equalTo: shelfImageView.centerYAnchor, constant: 0).isActive = true
        addConstraintsWithFormat(format: "V:|-15-[v0]-65-|", views: itemCountLabel)
        addConstraintsWithFormat(format: "V:|-15-[v0]-65-|", views: ShelfNameLabel)
        addConstraintsWithFormat(format: "V:[v0(80)]", views: shelfImageView)
        shelfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }

    
    func setupViews() {
        guard let shelf = shelf, let imageAsData = shelf.photo else {return}
        let photo = UIImage(data: imageAsData)
        backgroundColor = .white
        shelfImageView.image = photo ?? #imageLiteral(resourceName: "imagePlaceHolder")
        ShelfNameLabel.text = shelf.name
        itemCountLabel.text = "\(shelf.items?.count ?? 0) Items"
        shelfImageView.layer.masksToBounds = true
        shelfImageView.layer.cornerRadius = CornerRadius.imageView
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

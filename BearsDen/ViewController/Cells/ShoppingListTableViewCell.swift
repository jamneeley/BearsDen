//
//  ShoppingListTableViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let isPurchasedButton = UIButton()
    
    var shoppingItem: ShoppingItem? {
        didSet {
            setupViews()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        guard let item = shoppingItem else {return}
        addSubview(nameLabel)
        addSubview(isPurchasedButton)
        setupButton()
        nameLabel.text = item.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        setupButton()
        addConstraintsWithFormat(format: "V:|-15-[v0]-15-|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(35)]-10-|", views: isPurchasedButton)
        addConstraintsWithFormat(format: "H:|-5-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "H:[v0(35)]-5-|", views: isPurchasedButton)
    }
    
    func setupButton() {
        guard let isPurchased = shoppingItem?.isPurchased else {return}
        if isPurchased {
            isPurchasedButton.setImage(#imageLiteral(resourceName: "checkedBox"), for: .normal)
        } else {
            isPurchasedButton.setImage(#imageLiteral(resourceName: "checkMarkBox"), for: .normal)
        }
        isPurchasedButton.addTarget(self, action: #selector(isPurchasedButtonTapped), for: .touchUpInside)
    }
    
    @objc func isPurchasedButtonTapped(){
        guard let item = shoppingItem else {return}
        if item.isPurchased {
            isPurchasedButton.setImage(#imageLiteral(resourceName: "checkMarkBox"), for: .normal)
            ShoppingItemController.shared.isPurchasedChangedFor(ShoppingItem: item, isPurchased: false)
        } else {
            isPurchasedButton.setImage(#imageLiteral(resourceName: "checkedBox"), for: .normal)
            ShoppingItemController.shared.isPurchasedChangedFor(ShoppingItem: item, isPurchased: true)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

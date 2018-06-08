//
//  GoalsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {

    let seperator = UIView()
    var titleLabel = UILabel()
    
    
    var goal: Goal? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let localGoal = goal else {return}
        titleLabel.text = localGoal.name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(seperator)
        addSubview(titleLabel)  
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: seperator)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: titleLabel)
        addConstraintsWithFormat(format: "V:[v0(2)]-5-[v1(80)]-5-|", views: seperator, titleLabel)
        seperator.backgroundColor = Colors.mediumGray
        seperator.layer.cornerRadius = 4
        self.backgroundColor = Colors.veryLightGray
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}

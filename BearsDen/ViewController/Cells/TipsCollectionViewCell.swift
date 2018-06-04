//
//  TipsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/21/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    

    var titleLabel = UILabel()
    
    var tip: [String: String]? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: titleLabel)
        titleLabel.text = "blah"
//        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: titleLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func updateViews() {
        guard let tip = tip else {return}
        backgroundColor = .blue
        titleLabel.text = tip.keys.first
    }
}

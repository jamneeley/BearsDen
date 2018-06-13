//
//  TipsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/21/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {

    let seperator = UIView()
    var titleLabel = UILabel()
    
    
    var tip: [String: String]? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(seperator)
        addSubview(titleLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: seperator)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0(80)]", views: titleLabel)
        addConstraintsWithFormat(format: "V:[v0(2)]-5-|", views: seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        seperator.layer.cornerRadius = 4
        self.backgroundColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func updateViews() {
        guard let tip = tip else {return}
        titleLabel.text = tip.keys.first
    }
}

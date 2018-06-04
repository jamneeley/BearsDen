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
        addConstraintsWithFormat(format: "H:|-\(frame.size.width * 0.25)-[v0]-\(frame.size.width * 0.25)-|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-\(frame.size.height * 0.25)-[v0]-\(frame.size.height * 0.25)-|", views: titleLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func updateViews() {
        guard let tip = tip else {return}
        
        backgroundColor = Colors.green
        titleLabel.text = tip.keys.first
    }
}

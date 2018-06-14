//
//  TipsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/21/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties

    let seperator = UIView()
    var titleLabel = UILabel()
    
    
    var tip: [String: String]? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Cell Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSeperator()
        setupTitleLabel()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
////////////////
    //MARK: - Views
////////////////
    
    func updateViews() {
        guard let tip = tip else {return}
        titleLabel.text = tip.keys.first
    }
    
    func setupSeperator() {
        addSubview(seperator)
        addConstraintsWithFormat(format: "V:[v0(2)]-5-|", views: seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        seperator.layer.cornerRadius = 4
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-|", views: seperator)
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0(80)]", views: titleLabel)
    }
}

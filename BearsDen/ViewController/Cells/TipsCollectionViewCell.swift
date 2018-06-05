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
    
    func updateViews() {
        guard let tip = tip else {return}
        titleLabel.text = tip.keys.first
    }
    
    func randomNumber(from: UInt32, to: UInt32) -> CGFloat{
        return CGFloat((arc4random() % (to - from)) + from)
    }
    
//    func randomColor() ->UIColor {
////        let hue = randomNumber(from: 165, to: 250)
////        let saturation = randomNumber(from: 5, to: 15)
//        let brightness = randomNumber(from: 85, to: 95)
//
//        return UIColor(hue: 1.0/360.0, saturation: 0/100.0, brightness: brightness/100.0, alpha: 1.0)
//    }
}

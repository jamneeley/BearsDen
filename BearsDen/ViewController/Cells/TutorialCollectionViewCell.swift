//
//  TutorialCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell {
    
    let tutorialLabel = UILabel()
    
    var tutorialName: String? {
        didSet {
            guard let name = tutorialName else {return}
            tutorialLabel.text = name
        }
    }
    
    //MARK: - Cell Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        backgroundColor = .white
        addSubview(tutorialLabel)
        tutorialLabel.textAlignment = .center
        tutorialLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        addConstraintsWithFormat(format: "V:|-\(frame.height * 0.35)-[v0]", views: tutorialLabel)
        tutorialLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }

    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? Colors.softBlue : .white
        }
    }
}

//
//  TutorialCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/11/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TutorialDetailCollectionViewCell: UICollectionViewCell {
    
    let backgroundBlueView = UIView()
    let tutorialImageView = UIImageView()
    let directionsLabel = UILabel()
    
    var instruction: Instruction? {
        didSet {
            guard let instruction = instruction else {return}
            tutorialImageView.image = instruction.image
            directionsLabel.text = instruction.directions
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackGroundView()
        setupImageView()
        setupDirectionsLabel()
    }
    
    func setupBackGroundView() {
        addSubview(backgroundBlueView)
        backgroundBlueView.addSubview(tutorialImageView)
        backgroundBlueView.addSubview(directionsLabel)
        
        backgroundBlueView.backgroundColor = Colors.softBlue
        backgroundBlueView.layer.cornerRadius = CornerRadius.imageView
        backgroundBlueView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBlueView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.1).isActive = true
        backgroundBlueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width * 0.08).isActive = true
        backgroundBlueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: frame.width * -0.08).isActive = true
        backgroundBlueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: frame.height * -0.1).isActive = true
        
    }
    
    func setupImageView() {
        tutorialImageView.layer.cornerRadius = CornerRadius.imageView
        tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
        tutorialImageView.topAnchor.constraint(equalTo: backgroundBlueView.topAnchor, constant: frame.height * 0.05).isActive = true
        tutorialImageView.leadingAnchor.constraint(equalTo: backgroundBlueView.leadingAnchor, constant: frame.width * 0.05).isActive = true
        tutorialImageView.trailingAnchor.constraint(equalTo: backgroundBlueView.trailingAnchor, constant: frame.width * -0.05).isActive = true
        tutorialImageView.bottomAnchor.constraint(equalTo: backgroundBlueView.centerYAnchor, constant: frame.height * 0.15).isActive = true
    }
    
    func setupDirectionsLabel() {
    
        directionsLabel.numberOfLines = 0
        directionsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        directionsLabel.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 20).isActive = true
        directionsLabel.leadingAnchor.constraint(equalTo: backgroundBlueView.leadingAnchor, constant: frame.width * 0.05).isActive = true
        directionsLabel.trailingAnchor.constraint(equalTo: backgroundBlueView.trailingAnchor, constant: frame.width * -0.05).isActive = true
        directionsLabel.bottomAnchor.constraint(equalTo: backgroundBlueView.bottomAnchor, constant: frame.height * -0.05).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  WelcomeToBearsDenCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/13/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
protocol WelcomeToBearsDenCollectionViewCellDelegate: class {
    func nextButtonPressed()
}

class WelcomeToBearsDenCollectionViewCell: UICollectionViewCell {
    
    let backgroundBlueView = UIView()
    let tutorialImageView = UIImageView()
    let directionsLabel = UILabel()
    let welcomeLabel = UILabel()
    let nextButton = UIButton()
    weak var delegate: WelcomeToBearsDenCollectionViewCellDelegate?
    
    var pageNumber: Int?
    
    var instruction: Instruction? {
        didSet {
            guard let instruction = instruction,
            let pageNumber  = pageNumber else {return}
            if pageNumber < 2  {
                setupImageView()
                setupDirectionsLabel()
                tutorialImageView.image = instruction.image
                directionsLabel.text = instruction.directions
            } else if pageNumber == 2{
                setupWelcomePage()
                setupNextButton()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupBackGroundView()
        
    }
    
    //for first 2 pages
    func setupBackGroundView() {
        addSubview(backgroundBlueView)
        
        backgroundBlueView.backgroundColor = Colors.softBlue
        backgroundBlueView.layer.cornerRadius = CornerRadius.imageView
        backgroundBlueView.frame = CGRect(x: 0, y: 0, width: frame.width * 0.87, height: frame.height * 0.815)
        backgroundBlueView.dropShadow()
        backgroundBlueView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBlueView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.1).isActive = true
        backgroundBlueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width * 0.08).isActive = true
        backgroundBlueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: frame.width * -0.08).isActive = true
        backgroundBlueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: frame.height * -0.1).isActive = true
    }
    
    func setupImageView() {
        backgroundBlueView.addSubview(tutorialImageView)
        tutorialImageView.layer.cornerRadius = CornerRadius.imageView
        tutorialImageView.clipsToBounds = true
        tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
        tutorialImageView.topAnchor.constraint(equalTo: backgroundBlueView.topAnchor, constant: frame.height * 0.05).isActive = true
        tutorialImageView.leadingAnchor.constraint(equalTo: backgroundBlueView.leadingAnchor, constant: frame.width * 0.05).isActive = true
        tutorialImageView.trailingAnchor.constraint(equalTo: backgroundBlueView.trailingAnchor, constant: frame.width * -0.05).isActive = true
        tutorialImageView.bottomAnchor.constraint(equalTo: backgroundBlueView.centerYAnchor, constant: frame.height * 0.15).isActive = true
    }
    
    func setupDirectionsLabel() {
        backgroundBlueView.addSubview(directionsLabel)
        directionsLabel.numberOfLines = 0
        directionsLabel.textAlignment = .center
        directionsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        directionsLabel.translatesAutoresizingMaskIntoConstraints = false
        directionsLabel.topAnchor.constraint(equalTo: tutorialImageView.bottomAnchor, constant: 10).isActive = true
        directionsLabel.leadingAnchor.constraint(equalTo: backgroundBlueView.leadingAnchor, constant: frame.width * 0.04).isActive = true
        directionsLabel.trailingAnchor.constraint(equalTo: backgroundBlueView.trailingAnchor, constant: frame.width * -0.04).isActive = true
        directionsLabel.bottomAnchor.constraint(equalTo: backgroundBlueView.bottomAnchor, constant: frame.height * -0.01).isActive = true
    }
    
    //for last page!
    
    func setupWelcomePage() {
        backgroundBlueView.addSubview(welcomeLabel)
        welcomeLabel.text = "We're happy and excited to help with your food storage! :)"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: backgroundBlueView.topAnchor, constant: frame.height * 0.1).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: backgroundBlueView.leadingAnchor, constant: frame.width * 0.05).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: backgroundBlueView.trailingAnchor, constant: frame.width * -0.05).isActive = true
        welcomeLabel.bottomAnchor.constraint(equalTo: backgroundBlueView.bottomAnchor, constant: frame.height * -0.3).isActive = true
    }
    
    func setupNextButton() {
        backgroundBlueView.addSubview(nextButton)
        nextButton.frame = CGRect(x: backgroundBlueView.frame.width * 0.5 - 50, y: backgroundBlueView.frame.height * 0.6, width: 100, height: 100)
        nextButton.setTitle("Lets Start", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = Colors.green
        nextButton.layer.cornerRadius = 0.5 * nextButton.bounds.size.width
        nextButton.clipsToBounds = true
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc func nextButtonPressed() {
        delegate?.nextButtonPressed()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

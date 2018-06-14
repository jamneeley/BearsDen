//
//  SettingsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties

    var setting: MenuItem? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }

    let nameLabel = UILabel()
    let iconImageView = UIImageView()
    
    //MARK: - Cell Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? Colors.softBlue : .white
            self.nameLabel.textColor = isHighlighted ? .white : Colors.verydarkGray
            iconImageView.tintColor = isHighlighted ? .white : Colors.mediumGray
        }
    }
    
//////////////////////
//Views
//////////////////////
    
    func setupViews() {
        backgroundColor = .white
        //Label
        addSubview(nameLabel)
        nameLabel.text = "Setting"
        nameLabel.textColor = Colors.verydarkGray
        //imageView
        addSubview(iconImageView)
        iconImageView.image = UIImage(named: "settingsGear2x")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Colors.mediumGray
        //constraints
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-20-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}

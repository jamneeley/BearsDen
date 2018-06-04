//
//  SettingsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 5/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? Colors.softBlue : .white
            self.nameLabel.textColor = isHighlighted ? .white : Colors.darkGray
            iconImageView.tintColor = isHighlighted ? .white : Colors.mediumGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.textColor = Colors.darkGray
        return label
    }()
    
    let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "settingsGear2x")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.mediumGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-20-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupViews() {
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}

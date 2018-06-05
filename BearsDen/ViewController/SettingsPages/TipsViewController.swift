//
//  TipsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    let sectionHeaderLabel = UILabel()
    var sectionHeader: String? {
        didSet{
            updateHeader()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionHeaderLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: sectionHeaderLabel)
        addConstraintsWithFormat(format: "V:|-\(frame.size.height * 0.3)-[v0]", views: sectionHeaderLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func updateHeader() {
        guard let sectionHeader = sectionHeader else {return}
        sectionHeaderLabel.text = sectionHeader
    }
}


class TipsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "tipsCell"
    let header = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header)
        setupObjects()
    }
    
    func setupObjects() {
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header, for: indexPath) as? SectionHeader {
            sectionHeader.backgroundColor = .white
            sectionHeader.sectionHeader = TipsController.shared.sectionHeaders[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TipsController.shared.tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TipsController.shared.tips[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tip = TipsController.shared.tips[indexPath.section][indexPath.row]
        
        let tipDetailVC = TipDetailViewController()
        tipDetailVC.tip = tip
        let navController = UINavigationController(rootViewController: tipDetailVC)
        self.present(navController, animated: true, completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TipsCollectionViewCell
        let tip = TipsController.shared.tips[indexPath.section][indexPath.row]
        cell.tip = tip
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension TipsViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

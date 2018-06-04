//
//  TipDetailViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/4/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class TipDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let titleLabel = UILabel()
    let textView = UITextView()
    var contentSize: Int?

    
    var tip: [String: String]? {
        didSet {
            var number = 0
            guard let tipValue = tip?.values.first else {return}
            for _ in tipValue {
                number += 1
            }
            updateViews()
            contentSize = number
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .done, target: self, action: #selector(dismissView))
    }
    
    func updateViews() {
        guard let tip = tip else {return}
        titleLabel.text = tip.keys.first
        textView.text = tip.values.first
        print(textView.frame.height)
    }
    
    func setupObjects() {
        setupScrollView()
        setupContentView()
        setupTitleLabel()
        setupTextView()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isUserInteractionEnabled = true
        scrollView.indicatorStyle = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupContentView() {
        guard let optionalSize = contentSize else {return}
        let size = Double(view.frame.height) + Double(optionalSize) * 0.45
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true
    }
    
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.size.height * 0.03).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.size.width * 0.05).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.size.width * -0.05).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.15).isActive = true
    }

    func setupTextView() {
        contentView.addSubview(textView)
        textView.textAlignment = .left
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.frame.size.height * 0.04).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.size.width * 0.05).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.size.width * -0.05).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.frame.size.height * -0.1).isActive = true
    }
}

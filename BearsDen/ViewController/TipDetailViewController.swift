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
    let titleLabel = UILabel()
    let textView = UITextView()

    
    var tip: [String: String]? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        view.backgroundColor = .yellow
    }
    
    func updateViews() {
        guard let tip = tip else {return}
        titleLabel.text = tip.keys.first
        textView.text = tip.values.first
    }
    
    func setupObjects() {
        setupScrollView()
        setupTitleLabel()
        setupTextView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .cyan
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.frame.size.height * 0.1).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: scrollView.frame.size.width * 0.1).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: scrollView.frame.size.width * -0.1).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.frame.size.height * 0.15).isActive = true
    }

    func setupTextView() {
//        scrollView.addSubview(textView)
//        textView.backgroundColor = .blue
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: scrollView.frame.size.height * 0.1).isActive = true
//        textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: scrollView.frame.size.width * 0.1).isActive = true
//        textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: scrollView.frame.size.width * 0.1).isActive = true
//        textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: scrollView.frame.size.height * 0.1).isActive = true
    }
    
}

//
//  ItemsViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let itemTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        setupObjects()
    }
    
    func setupObjects() {
        setupTableView()
        setupNavigationBar()
    }
    
    func setupTableView() {
        view.addSubview(itemTableView)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        setupTableViewConstraints()
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationController?.navigationBar.barTintColor = Colors.softBlue
        navigationItem.rightBarButtonItem?.tintColor = Colors.darkPurple
        navigationItem.leftBarButtonItem?.tintColor = Colors.darkPurple
    }
    
    func setupTableViewConstraints() {
        itemTableView.translatesAutoresizingMaskIntoConstraints = false
        itemTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        itemTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        itemTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        itemTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "itemCell")
       itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = "first item"
        cell.detailTextLabel?.text = "first item detail"
        return cell
    }
}

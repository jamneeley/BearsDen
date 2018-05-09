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
    var shelf: Shelf?
    let manualAddButton = UIButton()
    let barCodeAddButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        setupObjects()
    }
    
    func setupObjects() {
        setupTableView()
        setupNavigationBar()
        setupManualAddButton()
        setupBarCodeAddButton()
        
    }
    
    func setupTableView() {
        view.addSubview(itemTableView)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        setupTableViewConstraints()
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = Colors.softBlue
    }
    
    func setupManualAddButton() {
        itemTableView.addSubview(manualAddButton)
        manualAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        manualAddButton.clipsToBounds = true
        manualAddButton.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        manualAddButton.backgroundColor = Colors.green
        manualAddButton.addTarget(self, action: #selector(addManualButtonPressed), for: .touchUpInside)
        manualAddButton.frame = CGRect(x: view.frame.height * 0.85, y: view.frame.width * 0.4, width: 50, height: 50)
    }
    
    func setupBarCodeAddButton() {
        itemTableView.addSubview(barCodeAddButton)
        barCodeAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        barCodeAddButton.clipsToBounds = true
        barCodeAddButton.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        barCodeAddButton.backgroundColor = Colors.green
        barCodeAddButton.addTarget(self, action: #selector(addManualButtonPressed), for: .touchUpInside)
        barCodeAddButton.frame = CGRect(x: view.frame.height * 0.85, y: view.frame.width * 0.6, width: 50, height: 50)
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
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addManualButtonPressed() {
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelf?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "itemCell")
       itemTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        if shelf != nil {
            if let item = shelf?.items?[indexPath.row] as? Item {
                cell.textLabel?.text = "\(item.name ?? "")"
                cell.detailTextLabel?.text = "\(item.expirationDate ?? Date())"
                return cell
            }
        } else {
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

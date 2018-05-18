//
//  ShelvesTableViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShelvesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()

    
    var update: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shelfCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setupObjects() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupTableViewConstraints()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.user?.shelves?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "shelfCell")
        tableView.dequeueReusableCell(withIdentifier: "shelfCell", for: indexPath)
        if let shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf {
            cell.shelf = shelf
            return cell
        } else {
            return UITableViewCell()
        }
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf else {return}
            ShelfController.shared.delete(Shelf: shelf)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemView = ItemsViewController()
        guard let shelf: Shelf = UserController.shared.user?.shelves?[indexPath.row] as? Shelf else {return}
        itemView.shelf = shelf
        let navItem = UINavigationController(rootViewController: itemView)
        present(navItem, animated: true, completion: nil)
    }
}


////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension ShelvesViewController {
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

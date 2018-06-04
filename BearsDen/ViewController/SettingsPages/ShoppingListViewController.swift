//
//  ShoppingListViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let shoppingListTableView = UITableView()
    
    var update: Bool? {
        didSet {
            shoppingListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        shoppingListTableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "shoppingCell")
        setupTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = UserController.shared.user?.shoppingItems?.count ?? 0
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingListTableViewCell
        if let shoppingItem = UserController.shared.user?.shoppingItems?[indexPath.row] as? ShoppingItem {
            cell.shoppingItem = shoppingItem
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = UserController.shared.user?.shoppingItems?[indexPath.row] as? ShoppingItem else {return}
            ShoppingItemController.shared.delete(ShoppingItem: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension ShoppingListViewController {
    func setupTableView() {
        view.addSubview(shoppingListTableView)
        shoppingListTableView.translatesAutoresizingMaskIntoConstraints = false
        shoppingListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        shoppingListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        shoppingListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        shoppingListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
}

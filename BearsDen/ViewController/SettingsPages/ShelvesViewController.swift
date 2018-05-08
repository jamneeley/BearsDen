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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shelfCell")
    }
    
    func setupObjects() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        setupTableViewConstraints()
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "shelfCell")
        tableView.dequeueReusableCell(withIdentifier: "shelfCell", for: indexPath)
        cell.textLabel?.text = "first"
        cell.detailTextLabel?.text = "second"
        return cell
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
}

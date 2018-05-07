//
//  ShelvesTableViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/2/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShelvesTableViewController: UITableViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shelfCell")
    }
    
    func setupObjects() {
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settingIconX2.png"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addX2"), style: .plain, target: self, action: #selector(addShelfButtonTapped))
        
        navigationController?.navigationBar.barTintColor = Colors.softBlue
        navigationItem.rightBarButtonItem?.tintColor = Colors.darkPurple
        navigationItem.leftBarButtonItem?.tintColor = Colors.darkPurple
        //for when it is set up
        //        navigationItem.title = UserController.shared.user.houseHoldName
        
    }
    
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.shelvesView = self
        return launcher
    }()
    
    @objc func settingsButtonTapped() {
        settingsLauncher.showSettings()
    }
    
    func showControllerFor(Setting setting: Setting) {
        let dummyViewController = UIViewController()
//        dummyViewController.navigationItem.title = setting.name
        dummyViewController.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        //sets the navbar title text color....FIGURE OUT
//        navigationController?.navigationBar.titleTextAttributes = .white
        navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
    @objc func addShelfButtonTapped() {
        let itemsTableView = ItemsViewController()
//        let itemNavigationController = UINavigationController(rootViewController: itemsTableView)
        navigationController?.pushViewController(itemsTableView, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.user?.shelves?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "shelfCell")
        tableView.dequeueReusableCell(withIdentifier: "shelfCell", for: indexPath)
        cell.textLabel?.text = "first"
        cell.detailTextLabel?.text = "second"
        return cell
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier = 
//    }
 

}

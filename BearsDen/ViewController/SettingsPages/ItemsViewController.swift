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
    let manualAddButton = UIButton(type: .custom)
    let barCodeAddButton = UIButton(type: .custom)

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
        navigationItem.title = shelf?.name
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = Colors.softBlue
    }
    
    func setupManualAddButton() {
        manualAddButton.frame = CGRect(x: view.frame.width * 0.35 - 30, y: view.frame.height * 0.88, width: 60, height: 60)
        view.addSubview(manualAddButton)
        manualAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        manualAddButton.clipsToBounds = true
        manualAddButton.imageView?.tintColor = nil
        manualAddButton.setImage(#imageLiteral(resourceName: "ClipBoardButton"), for: .normal)
        manualAddButton.backgroundColor = Colors.green
        manualAddButton.addTarget(self, action: #selector(startHighlightManual), for: .touchDown)
        manualAddButton.addTarget(self, action: #selector(addManualButtonPressed), for: .touchUpInside)
        manualAddButton.addTarget(self, action: #selector(stopHighlightManual), for: .touchUpOutside)
    }

    func setupBarCodeAddButton() {
        barCodeAddButton.frame = CGRect(x: view.frame.width * 0.65 - 30, y: view.frame.height * 0.88, width: 60, height: 60)
        view.addSubview(barCodeAddButton)
        barCodeAddButton.layer.cornerRadius = 0.5 * manualAddButton.bounds.size.width
        barCodeAddButton.clipsToBounds = true
        barCodeAddButton.imageView?.tintColor = nil
        barCodeAddButton.setImage(#imageLiteral(resourceName: "barCodeButton"), for: .normal)
        barCodeAddButton.backgroundColor = Colors.green
        barCodeAddButton.addTarget(self, action: #selector(startHighlightBar), for: .touchDown)
        barCodeAddButton.addTarget(self, action: #selector(addBarButtonPressed), for: .touchUpInside)
        barCodeAddButton.addTarget(self, action: #selector(stopHighlightBar), for: .touchUpOutside)
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
    @objc func startHighlightManual() {
        manualAddButton.layer.backgroundColor = Colors.softBlue.cgColor
        manualAddButton.imageView?.tintColor = .white
    }
    @objc func stopHighlightManual() {
        manualAddButton.layer.backgroundColor = Colors.green.cgColor
        manualAddButton.imageView?.tintColor = nil
    }
    @objc func startHighlightBar() {
        barCodeAddButton.layer.backgroundColor = Colors.softBlue.cgColor
        barCodeAddButton.imageView?.tintColor = .white
    }
    @objc func stopHighlightBar() {
        barCodeAddButton.layer.backgroundColor = Colors.green.cgColor
        barCodeAddButton.imageView?.tintColor = nil
    }
    @objc func addManualButtonPressed() {
        stopHighlightManual()
        let addManualView = AddManualItemViewController()
        navigationController?.pushViewController(addManualView, animated: true)
    }
    
    @objc func addBarButtonPressed() {
        stopHighlightBar()
        let addBarView = AddBarCodeItemViewController()
        navigationController?.pushViewController(addBarView, animated: true)
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

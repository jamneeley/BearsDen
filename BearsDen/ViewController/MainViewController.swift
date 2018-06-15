//
//  MainViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/7/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, shelfEditViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, shelvesViewControllerDelegate  {
    
    //MARK: - Properties
    //non page dependent objects
    let navBar = UIView()
    let settingsButton = UIButton(type: UIButtonType.system)
    let navBarLabel = UILabel()
    
    //viewcontrollers
    lazy var shelvesView: ShelvesViewController = {
        let sv = ShelvesViewController()
        sv.delegate = self
        return sv
    }()
    lazy var goalsView: GoalsViewController = {
        return GoalsViewController()
    }()
    lazy var shoppingView: ShoppingListViewController = {
        return ShoppingListViewController()
    }()
    lazy var calculatorView: CalculatorViewController = {
       return CalculatorViewController()
    }()
    lazy var tipsView: TipsViewController = {
        return TipsViewController()
    }()
    lazy var myDenView: MyDenViewController = {
        return MyDenViewController()
    }()
    lazy var settingsview: SettingsViewController = {
        return SettingsViewController()
    }()

    let blackView = UIView()
    
    lazy var editShelfViewController: ShelfEditViewController = {
        let view = ShelfEditViewController()
        return view
    }()

    //Page Dependent Button
    let shelvesAddButton = UIButton(type: UIButtonType.system)
    let goalsAddButton = UIButton(type: UIButtonType.system)
    let shoppingAddButton = UIButton(type: UIButtonType.system)
    
    // current page in containerView property
    var globalCurrentView: Int?
    
    var inset: CGFloat = 0
    var layedOut = false
    
    // computed settings launcher....only fires code once
    lazy var menuLauncher: MenuLauncher = {
        let launcher = MenuLauncher()
        launcher.mainParentView = self
        return launcher
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inset = view.frame.height * 0.1
    }
    
    override func viewWillLayoutSubviews() {
        print("will layot")
        super.viewWillLayoutSubviews()
        if !layedOut {
            layedOut = true
            
            switch view.safeAreaInsets.top {
            case 0...20:
                print("0...20")
                inset = view.frame.height * 0.1
            case 21...60:
                print("21...40")
                inset = view.frame.height * 0.11
            default:
                print("bigger than 60")
            }
        
            setupNavBar()
            setupShelvesView()
        }
    }


    //MARK: - Button Methods
    
    @objc func settingsButtonTapped() {
        switch globalCurrentView{
        case 4:
            calculatorView.endEdit = true
        case 7:
            settingsview.endEdit = true
        default:
            print("")
        }
        
        menuLauncher.showMenu()
    }
    
        // SHELF METHODS
    @objc func addShelfButtonTapped() {
        print("addShelfButton Pressed")
        guard let shelfEditView = editShelfViewController.view else {return}
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            self.addChildViewController(editShelfViewController)
            view.addSubview(shelfEditView)
            window.addSubview(blackView)
            window.addSubview(shelfEditView)
            shelfEditView.layer.cornerRadius = CornerRadius.imageView
            shelfEditView.layer.borderColor = Colors.softBlue.cgColor
            shelfEditView.layer.borderWidth = 2
            editShelfViewController.delegate = self
            editShelfViewController.shelfImage = #imageLiteral(resourceName: "BearOnHill")
            let width = window.frame.width * 0.8
            let height = window.frame.height * 0.75
            
            shelfEditView.frame = CGRect(x: (window.frame.width - width), y: -(window.frame.height), width: width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            self.blackView.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                shelfEditView.frame = CGRect(x: (window.frame.width - width) / 2, y: (window.frame.height - height) / 2, width: shelfEditView.frame.width, height: shelfEditView.frame.height)
            }, completion: nil)
        }
    }
    @objc func handleDismiss() {

        if let window = UIApplication.shared.keyWindow {
            self.shelvesView.update = true
            guard let shelfEditView = editShelfViewController.view else {return}
            editShelfViewController.removeInfo = true
            self.blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                shelfEditView.frame = CGRect(x: -(window.frame.width), y: 0, width: shelfEditView.frame.width, height: shelfEditView.frame.height)
                    shelfEditView.endEditing(true)
            }) { (success) in
            }
        }
    }
    
    func selectLibraryPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func selectCameraPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            editShelfViewController.shelfImage = image
        } else {
            print("error picking image from imagepicker")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
        // Goal METHODS
    
    @objc func addGoalButtonTapped() {
        let goalDetailVC = GoalDetailViewController()
        let navController = UINavigationController(rootViewController: goalDetailVC)
        self.present(navController, animated: true, completion: nil)
    }
    
        // SHOPPING METHODS
    
    @objc func addShoppingItemButtonTapped() {
        let alert = UIAlertController(title: "Add shopping item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.autocorrectionType = UITextAutocorrectionType.no
            textField.returnKeyType = .done
        }
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { (success) in
            guard let name = alert.textFields?.first?.text, !name.isEmpty,
                let user = UserController.shared.user else {return}
            ShoppingItemController.shared.createShoppingItem(ForUser: user, name: name)
            self.shoppingView.update = true
        }
        alert.addAction(dismiss)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Cell Tapped
    
    func didSelectCellAtRow(shelf: Shelf) {
        let itemView = ItemsViewController()
        itemView.shelf = shelf
        let navController = UINavigationController(rootViewController: itemView)
        present(navController, animated: true, completion: nil)
    }

////////////////////////////////////////////////////////
//MARK: - Views
////////////////////////////////////////////////////////
    
    func setupNavBar() {
        view.addSubview(navBar)
        navBar.backgroundColor = Colors.softBlue
        navBar.tintColor = .white
        navBar.addSubview(settingsButton)
        navBar.addSubview(navBarLabel)
        navBar.addSubview(shelvesAddButton)
        setupLabel()
        setupNavBarConstraints()
        setupSettingsButtonConstraints()
        setupSettingsButtons()
        setupShelvesButton()
        setup(Button: goalsAddButton)
        setup(Button: shoppingAddButton)
        setupButtonTargets()
    }
    
    func setupLabel() {
        navBarLabel.text = "Your shelves"
        navBarLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navBarLabel.textColor = .white
        setupLabelConstraints()
    }
    
    func setup(Button button: UIButton) {
        button.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButtonTargets() {
        shelvesAddButton.addTarget(self, action: #selector(addShelfButtonTapped), for: .touchUpInside)
        goalsAddButton.addTarget(self, action: #selector(addGoalButtonTapped), for: .touchUpInside)
        shoppingAddButton.addTarget(self, action: #selector(addShoppingItemButtonTapped), for: .touchUpInside)
    }

    func setupShelvesView() {
        shelvesView.willMove(toParentViewController: self)
        addChildViewController(shelvesView)
        self.view.addSubview(shelvesView.view)
        shelvesView.view.frame = CGRect(x: 0, y: inset, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
//        shelvesView.view.frame = CGRect(x: 0, y: (view.safeAreaInsets.top) + view.frame.height * 0.08, width: view.frame.width, height: view.frame.height - (view.frame.height * 0.08))
        shelvesView.didMove(toParentViewController: self)
        globalCurrentView = 1
    }

    func setupSettingsButtons() {
        settingsButton.setImage(#imageLiteral(resourceName: "settingIconX2"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    func setupShelvesButton() {
        shelvesAddButton.setImage(#imageLiteral(resourceName: "addX2"), for: .normal)
        shelvesAddButton.translatesAutoresizingMaskIntoConstraints = false
        shelvesAddButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        shelvesAddButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8).isActive = true
    }
    func setupNavBarConstraints() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        navBar.bottomAnchor.constraint(equalTo: view.topAnchor, constant: inset).isActive = true
//        navBar.bottomAnchor.constraint(equalTo: view.topAnchor, constant: (view.safeAreaInsets.top) + view.frame.height * 0.08).isActive = true
        print(view.safeAreaInsets.top)
    }
    
    func setupSettingsButtonConstraints() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 8).isActive = true
    }
    
    func setupLabelConstraints() {
        navBarLabel.translatesAutoresizingMaskIntoConstraints = false
        navBarLabel.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8).isActive = true
        navBarLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor, constant: 0).isActive = true
    }
}



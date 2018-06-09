//
//  GoalDetailViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GoalDetailCollectionViewCellDelegate {
    
    //Top Portion of Screen
    let scrollView = UIScrollView()
    let contentView = UIView()
    let singleTap = UITapGestureRecognizer()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStack = UIStackView()
    let dateOfCompletionLabel = UILabel()
    let datePicker = UIDatePicker()
    let seperator = UIView()
    let goalItemLabel = UILabel()
    
    var contentViewHeight: CGFloat = 0
    
    var contentHeightAnchor: NSLayoutConstraint?

    var selectedCellsIndex: [Int] = []
    
    //Bottom Portion of screen
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Colors.veryLightGray
        cv.allowsSelection = false
        return cv
    }()
    
    let cellID = "itemCell"
    
    var goal: Goal? {
        didSet {
            updateViews()
        }
    }
    var goalItems = [GoalItem]()
    
    func updateViews() {
        guard let goal = goal,
        let goalSet = goal.goalItems
        else {return}
        
        nameTextField.text = goal.name
        
        //appends all goal items to global array
        if let localGoalItems = goalSet.allObjects as? [GoalItem] {
            for item in localGoalItems {
                goalItems.append(item)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewHeight = view.frame.height * 2.4
        view.backgroundColor = Colors.veryLightGray
        collectionView.register(GoalDetailCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //possibly let cell know to change picker view
    }
    
    func setupObjects() {
        setupNavigationBar()
        setupScrollView()
        setupSingleTap()
        setupContentView()
        setupNameStack()
        setupDateOfCompletionLabel()
        setupDatePicker()
        setupSeperator()
        setupGoalItemLabel()
        setupCollectionView()
    }

    ////////////////////
    //SAVE BUTTON PRESSED
    ///////////////////
    
    @objc func saveButtonPressed() {
        guard let nameText = nameTextField.text, !nameText.isEmpty,
        let user = UserController.shared.user else {presentNameAlert(); return}
        let completionDate = datePicker.date
        var cells = [GoalDetailCollectionViewCell]()
        
        //Go through all collectionView cells and append them to cells
        for number in 0..<13 {
            let index = IndexPath(item: number, section: 0)
            guard let cell = collectionView.cellForItem(at: index) as? GoalDetailCollectionViewCell else {return}
            cells.append(cell)
        }
        if let goal = goal {
            //remove all goalitems from the goal
            GoalController.shared.removeAllGoalItems(forGoal: goal)
            //then add all the new goal items to it
            for cell in cells {
                if cell.isSwitchSelected {
                    if cell.isCustom {
                        let categoryText = cell.catagory
                        let cellTextViewText = cell.customDescription
                        GoalItemController.shared.create(GoalItemfor: goal, category: categoryText, unit: "", amount: "", customText: cellTextViewText, isCustom: true, isComplete: false)
                    } else {
                        let amountText = cell.amountText
                        let unitText = cell.unit
                        let categoryText = cell.catagory
                        GoalItemController.shared.create(GoalItemfor: goal, category: categoryText, unit: unitText, amount: amountText, customText: "", isCustom: false, isComplete: false)
                    }
                }
            }
        } else {
            //CREATE GOAL. after its completed add all the goal items to it
            GoalController.shared.createNewGoal(name: nameText, creationDate: Date(), completionDate: completionDate, user: user) { (Goal) in
                //Go through all Cells and get the properties from them
                for cell in cells {
                    if cell.isSwitchSelected {
                        if cell.isCustom {
                            let categoryText = cell.catagory
                            let cellTextViewText = cell.customDescription
                            GoalItemController.shared.create(GoalItemfor: Goal, category: categoryText, unit: "", amount: "", customText: cellTextViewText, isCustom: true, isComplete: false)
                        } else {
                            let amountText = cell.amountText
                            let unitText = cell.unit
                            let categoryText = cell.catagory
                            GoalItemController.shared.create(GoalItemfor: Goal, category: categoryText, unit: unitText, amount: amountText, customText: "", isCustom: false, isComplete: false)
                        }
                    }
                }
            }
        }
        presentSaveAnimation()
        dismiss(animated: true, completion: nil)
    }
    
    func presentNameAlert() {
        let alert = UIAlertController(title: "Uh Oh", message: "Your goal needs a name :)", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow() {
        view.addGestureRecognizer(singleTap)
    }
    
    @objc func keyboardWillHide() {
        view.removeGestureRecognizer(singleTap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    func setupSingleTap() {
        singleTap.numberOfTapsRequired = 1
        singleTap.addTarget(self, action: #selector(disableKeyBoard))
    }
    
    @objc func disableKeyBoard() {
        view.endEditing(true)
    }
    
    
    func switchTapped(cell: UICollectionViewCell, indexPath: Int, isSelected: Bool) {
        //EXPAND
        if isSelected {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: self.view.frame.height * 0.3)
                cell.layer.borderWidth = 2
                cell.layer.borderColor = Colors.green.cgColor
                let height = self.contentViewHeight + self.view.frame.height * 0.2
                self.contentHeightAnchor?.isActive = false
                self.contentHeightAnchor = self.contentView.heightAnchor.constraint(equalToConstant: height)
                self.contentHeightAnchor?.isActive = true
                self.contentViewHeight = height
            }) { (success) in
            }
            for i in collectionView.visibleCells {
                guard let index = collectionView.indexPath(for: i) else {return}
                
                if index.row > indexPath {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                        i.frame = CGRect(x: 0, y: (i.frame.origin.y) + (cell.frame.height / 2 + 40), width: self.collectionView.frame.width, height: i.frame.height)
                    }) { (success) in
                    }
                }
            }
            //SHRINK
        } else {
            
            for i in collectionView.visibleCells {
                guard let index = collectionView.indexPath(for: i) else {return}
                if index.row > indexPath {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                        i.frame = CGRect(x: 0, y: (i.frame.origin.y) - (cell.frame.height / 2 + 40), width: self.collectionView.frame.width, height: i.frame.height)
                    }) { (success) in
                    }
                }
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: self.view.frame.height * 0.1)
                cell.layer.borderWidth = 0
                
                let height = self.contentViewHeight - self.view.frame.height * 0.2
                self.contentHeightAnchor?.isActive = false
                self.contentHeightAnchor = self.contentView.heightAnchor.constraint(equalToConstant: height)
                self.contentHeightAnchor?.isActive = true
                self.contentViewHeight = height
            }) { (success) in
            }
        }
    }
    
    
    //COLLECTIONVIEW DATA SOURCE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: view.frame.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PickerViewProperties.catagories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GoalDetailCollectionViewCell
        //setupCell
        let item = PickerViewProperties.catagories[indexPath.row]
        cell.layer.cornerRadius = 12
        cell.delegate = self
        cell.item = item
        cell.indexPath = indexPath
        if indexPath.row == 0 {
            cell.isCustom = true
        }
        //If Cell should be selected
        if !goalItems.isEmpty {
            for item in goalItems {
                if let category = item.category {
                    let localIndex = findIndexOfGoalItem(GoalCategory: category, indexOfCell: indexPath.row)
                    if indexPath.row == localIndex {
                        cell.goalItem = item
                    }
                }
            }
        }
        return cell
    }
    
    func findIndexOfGoalItem(GoalCategory category: String, indexOfCell: Int) -> Int {
        var index = 0
        for item in PickerViewProperties.catagories {
            if category == item {
                guard let position = PickerViewProperties.catagories.index(of: item) else {print("FAIL"); return 0}
                index = Int(position)
            }
        }
        return index
    }
    
    /////////////////////////////////////
    //SETUP
    ////////////////////////////////////
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = Colors.softBlue
        let navTitle = goal?.name ?? "New Goal"
        navigationItem.title = navTitle
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = Colors.veryLightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 2.4)
        contentHeightAnchor?.isActive = true
    }
    
    func setupNameStack() {
        contentView.addSubview(nameStack)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameTextField)
        nameStack.distribution = .fill
        nameStack.axis = .vertical
        nameStack.spacing = 2
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = CornerRadius.textField
        nameTextField.backgroundColor = .white
        nameTextField.setLeftPaddingPoints(5)
        nameTextField.setRightPaddingPoints(5)
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.layer.borderColor = Colors.softBlue.cgColor
        nameLabel.text = "Name"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameTextField.placeholder = "3 Month Storage"
        setupNameStackConstraints()
    }
    
    func setupDateOfCompletionLabel() {
        contentView.addSubview(dateOfCompletionLabel)
        dateOfCompletionLabel.text = "Goal timeline?"
        dateOfCompletionLabel.textAlignment = .center
        setupDateOfCompletionLabelConstraints()
        
    }
    func setupDatePicker() {
        contentView.addSubview(datePicker)
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        let monthsToAdd = 6
        datePicker.layer.cornerRadius = 12
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = Colors.softBlue.cgColor
        setupDatePickerConstraints()
        let newDate = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: Date())
        datePicker.date = newDate ?? Date()
    }
    
    
    func setupSeperator() {
        contentView.addSubview(seperator)
        seperator.backgroundColor = Colors.green
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.layer.cornerRadius = CornerRadius.textField
        seperator.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.2).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.2).isActive = true
        seperator.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32).isActive = true
    }
    
    func setupGoalItemLabel() {
        contentView.addSubview(goalItemLabel)
        if let localGoal = goal {
            goalItemLabel.text = "Items to stock for \(localGoal.name ?? "your goal")"
        } else {
            goalItemLabel.text = "Which items are you trying to stock?"
        }
        goalItemLabel.numberOfLines = 0
        goalItemLabel.textAlignment = .center
        goalItemLabel.translatesAutoresizingMaskIntoConstraints = false
        goalItemLabel.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 20).isActive = true
        goalItemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        goalItemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        goalItemLabel.bottomAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 45).isActive = true
    }
    
    func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: goalItemLabel.bottomAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -view.frame.height * 0.05).isActive = true
    }
    
    func setupNameStackConstraints() {
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.06).isActive = true
        nameStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.02).isActive = true
        nameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        nameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        nameStack.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.12).isActive = true
    }
    
    func setupDateOfCompletionLabelConstraints() {
        dateOfCompletionLabel.translatesAutoresizingMaskIntoConstraints =  false
        dateOfCompletionLabel.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10).isActive = true
        dateOfCompletionLabel.bottomAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 35).isActive = true
        dateOfCompletionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        dateOfCompletionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
    }
    
    func setupDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints =  false
        datePicker.topAnchor.constraint(equalTo: dateOfCompletionLabel.bottomAnchor, constant: 5).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: dateOfCompletionLabel.bottomAnchor, constant: view.frame.height * 0.2).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
    }
}

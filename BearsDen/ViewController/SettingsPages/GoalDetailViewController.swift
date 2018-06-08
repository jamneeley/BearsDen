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
    
    
    var selectedCellsIndex: [Int] = []
    
    //Bottom Portion of screen
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.allowsSelection = false
        return cv
    }()
    
    let cellID = "itemCell"

    
    var goal: Goal? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.green
        collectionView.register(GoalDetailCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        setupObjects()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    func updateViews() {
        guard let goalItems = goal?.goallItems else { return }
        var goalItemsArray = [GoalItem]()
        for item in goalItems {
            goalItemsArray.append(item as! GoalItem)
        }
    }
    
    @objc func saveButtonPressed() {
        if let _ = goal {
            print("updated Goal")
        } else {
            print("saved new Goal")
        }
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
                cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: self.view.frame.height * 0.35)
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
            }) { (success) in
            }
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: view.frame.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GoalItemList.possibleItemsForCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GoalDetailCollectionViewCell
        let item = GoalItemList.possibleItemsForCells[indexPath.row]
        cell.delegate = self
        cell.item = item
        cell.indexPath = indexPath
        if indexPath.row == 0 {
            cell.isCustom = true
        }
        cell.layer.cornerRadius = 12
        return cell
    }
    

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
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 2.7).isActive = true
        contentViewHeight = view.frame.height * 0.3
    }
    
    func setupNameStack() {
        contentView.addSubview(nameStack)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameTextField)
        nameStack.distribution = .fill
        nameStack.axis = .horizontal
        nameStack.spacing = 0
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = CornerRadius.textField
        nameTextField.setLeftPaddingPoints(5)
        nameTextField.setRightPaddingPoints(5)
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.layer.borderColor = Colors.softBlue.cgColor
        nameLabel.text = "Name: "
        nameTextField.placeholder = "3 Month Storage"
        setupNameStackConstraints()
    }
    
    func setupDateOfCompletionLabel() {
        contentView.addSubview(dateOfCompletionLabel)
        dateOfCompletionLabel.text = "Goal Completion Date: "
        dateOfCompletionLabel.textAlignment = .left
        setupDateOfCompletionLabelConstraints()
        
    }
    func setupDatePicker() {
        contentView.addSubview(datePicker)
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
        nameStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.02).isActive = true
        nameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: view.frame.width * 0.05).isActive = true
        nameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: view.frame.width * -0.05).isActive = true
        nameStack.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.07).isActive = true
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

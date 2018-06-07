//
//  GoalDetailViewController.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController, UITextFieldDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let singleTap = UITapGestureRecognizer()
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let nameStack = UIStackView()
    
    let dateOfCompletionLabel = UILabel()
    let datePicker = UIDatePicker()
    
    var goal: Goal? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.green
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
    }
    
    func updateViews() {
        guard let goal = goal else {return}
        
        
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
    

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackLargeX1"), style: .plain, target: self, action: #selector(backButtonPressed))
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
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height * 2).isActive = true
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

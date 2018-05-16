//
//  ShelfEditViewController.swift
//  BearsDen
//
//  Created by James Neeley on 5/16/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class ShelfEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert() {
//        let alert = UIAlertController(title: "Edit Shelf", message: "", preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            guard let shelf = self.shelf else {return}
//            textField.text = shelf.name
//        }
//        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
//        let save = UIAlertAction(title: "Save", style: .default) { (success) in
//            guard let shelfName = alert.textFields?.first?.text, !shelfName.isEmpty, let shelf = self.shelf else {return}
//            ShelfController.shared.updateName(Shelf: shelf, name: shelfName)
//            self.navigationItem.title = shelf.name
//        }
//        alert.addAction(dismiss)
//        alert.addAction(save)
//        present(alert, animated: true, completion: nil)
//        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        imagePicker.allowsEditing = false
//        self.present(imagePicker, animated: true) {
    }

}

////////////////////////////////////////////////////////
//CONSTRAINTS
////////////////////////////////////////////////////////

extension ShelfEditViewController {
    
}

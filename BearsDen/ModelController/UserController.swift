//
//  UserController.swift
//  BearsDen
//
//  Created by James Neeley on 5/1/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
import CoreData

class UserController {
    
    static let shared = UserController()
    var user: User?
    
    func updateUser(HouseholdName name: String, picture: UIImage, adults: String, kids: String) {
        if let user = user {
            user.houseHoldName = name
            let pictureAsData = UIImageJPEGRepresentation(picture, 1.0)
            user.picture = pictureAsData
            user.adults = adults
            user.kids = kids
            saveToCoreData()
            print("All User values updated")
        }
    }
    
    func createUser(housHouldName: String) {
        if user == nil {
            let newUser = User(houseHoldName: housHouldName)
            self.user = newUser
            saveToCoreData()
            print("new user created")
        } else {
            print("A User already exists")
        }
    }
    
    func updateUser(houseHoldName: String) {
        if let user = user {
            user.houseHoldName = houseHoldName
            saveToCoreData()
        } else {
            print("there is no current user")
        }
    }
    
    func change(Adult adults: String) {
        if let user = user {
            user.adults = adults
            saveToCoreData()
            print("Adults changed to \(adults)")
        } else {
            print("No user exists")
        }
    }
    
    func change(Kids kids: String) {
        if let user = user {
            user.kids = kids
            saveToCoreData()
            print("Kids changed to \(kids)")
        } else {
            print("No user exists")
        }
    }
    
    func change(Picture picture: UIImage) {
        if let user = user {
            let data = UIImageJPEGRepresentation(picture, 1.0)
            user.picture = data
            saveToCoreData()
            print("Picture added to user")
        } else {
            print("there is no user to save the picture to")
        }
    }
    
    func saveToCoreData() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch  {
            print("error saving to core date \(error), \(error.localizedDescription)")
        }
    }
    
    func loadFromCoreData() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try CoreDataStack.context.fetch(request)
            self.user = users.first
        } catch {
            print("Error decoding data from filemanager: \(error), \(error.localizedDescription)")
        }
    }
}

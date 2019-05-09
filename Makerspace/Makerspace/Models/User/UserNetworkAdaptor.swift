//
//  UserNetworkAdaptor.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import Firebase

class UserNetworkAdaptor {
    
    static let instance = UserNetworkAdaptor()
    init(){}
    
    
    //adds a user to the database
    func createFirebaseUser(user: User) {
        let values = ["name" : user.name, "email" : user.email, "status" : user.status] as [String : Any]
        db.collection("users").addDocument(data: values)
    }
    
    
    //updates the status variable in the database
    func updateUserStatus(user: User) {
        let fetchedUser = db.collection("Users").whereField("email", isEqualTo: user.email)
        
        if user.status == false {
            user.status = true
            let keys = ["name" : user.name, "email" : user.email, "status" : user.status, "currentRoom" : user.currentRoom!] as [String : Any]
            fetchedUser.setValuesForKeys(keys)
        }
        else {
            user.status = false
            let keys = ["name" : user.name, "email" : user.email, "status" : user.status, "currentRoom" : user.currentRoom!] as [String : Any]
            fetchedUser.setValuesForKeys(keys)
        }
    }
    
    
    //MUST be called after the local status of the user has been changed!!
    func updateUser(user: User) {
        if user.currentRoom != "" {
            db.collection("history").document(user.name).setData(["currentRoom" : user.currentRoom!])
        }
        else {
            db.collection("history").document(user.name).setData(["currentRoom" : user.currentRoom!])
        }
    }
        
        
    
    
    //closure communicating from Firebase to Network Adaptor
    func retrieveUsers(completionHandler handler: @escaping ([User]?) -> Void) {
        var existingUsers = [User]()
        db.collection("Users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting users from Firestore: \(error)")
            }
            else {
                for user in snapshot!.documents {
                    let data = user.data()
                    
                    let name = data["name"] as! String
                    let email = data["email"] as! String
                    let status = data["status"] as! Bool
                    let currentRoom = data["currentRoom"] as! String?
                    existingUsers.append(User(name: name, email: email, status: status, currentRoom: currentRoom))
                }
            }
            handler(existingUsers)
        }
    }
    
} //end class

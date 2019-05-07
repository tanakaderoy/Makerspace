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
        let values = ["name" : user.name, "email" : user.email, "status" : user.status, "badgeID" : user.badgeID] as [String : Any]
        db.collection("users").addDocument(data: values)
    }
    
    
    //updates the status variable in the database
    func updateUserStatus(status: Bool, user: User) {
        let fetchedUser = db.collection("users").whereField("email", isEqualTo: user.email)
        fetchedUser.setValue(status, forKey: "status")
    }
    
    
    func retrieveUsers() {
        var existingUsers = [User]()
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting users from Firestore: \(error)")
            }
            else {
                for user in snapshot!.documents {
                    print(user.data())
                    let data = user.data()
                    let name = data["name"] as! String
                    let email = data["email"] as! String
                    let badgeID = data["badgeID"] as! String
                    let status = data["status"] as! Bool
                    existingUsers.append(User(name: name, email: email, status: status, badgeID: badgeID))
                }
            }
        }
    }
    
} //end class

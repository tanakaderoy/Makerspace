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
        let values = ["name" : user.name, "email" : user.email, "status" : user.status, "currentRoom" : user.currentRoom ?? "None"] as [String : Any]
        db.collection("users").document(user.email).setData(values)
    }
    
    
    //updates the history table in database
    //MUST be called after the local status of the user has been changed!!
    func updateUser(user: User) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        if user.currentRoom != "" {
            if user.status == true {
                let data: [String : Any] = ["name" : user.name, "room" : user.currentRoom!, "startTime" : user.startTime, "endTime" : ""]
                db.collection("history").document(user.email).collection("sessions").document("\(formatter.string(from: user.startTime!))").setData(data)
                print(formatter.string(from: user.startTime!))
                db.collection("users").document(user.email).updateData(["status": user.status])
                db.collection("users").document(user.email).updateData(["currentRoom" : user.currentRoom!])
               
            }
            else {
                let data: [String : Any] = ["name" : user.name, "room" : user.currentRoom!, "endTime" : user.endTime]
               
                db.collection("history").document(user.email).collection("sessions").document("\(formatter.string(from: user.startTime!))").updateData(data)
                db.collection("users").document(user.email).updateData(["status": user.status])
            }
        }
        else {
            db.collection("history").document(user.name).setData(["currentRoom" : user.currentRoom!])
        }
    }
    func deleteUser(user: User) {
         db.collection("users").document(user.email).delete()
        print(db.collection("users"))
    }
        
        
    
    
    //closure communicating from Firebase to Network Adaptor
    func retrieveUsers(completionHandler handler: @escaping ([User]?) -> Void) {
        var existingUsers = [User]()
        db.collection("users").getDocuments { (snapshot, error) in
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

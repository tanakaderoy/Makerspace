//
//  UserNetworkAdaptor.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//
// Edited by Tanaka Mazivanhanga May 2019

import Foundation
import Firebase

class UserNetworkAdaptor {
    
    static let instance = UserNetworkAdaptor()
    init(){}
    
    //MARK: - Create, Update, Delete, Retrieve
    
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
                let data: [String : Any] = ["name" : user.name, "room" : user.currentRoom!, "startTime" : user.startTime!, "endTime" : ""]
                db.collection("history").document(user.email).collection("sessions").document("\(formatter.string(from: user.startTime!))").setData(data)
                print(formatter.string(from: user.startTime!))
                db.collection("users").document(user.email).updateData(["status": user.status])
                db.collection("users").document(user.email).updateData(["currentRoom" : user.currentRoom!])
            }
            else {
                let data: [String : Any] = ["name" : user.name, "room" : user.currentRoom!, "endTime" : user.endTime!]
                var startTime: String
                if let userStartTime = user.startTime {
                    startTime = formatter.string(from: userStartTime)
                }
                else {
                    startTime = "No Start Time"
                }
                db.collection("history").document(user.email).collection("sessions").document("\(startTime)").updateData(data)
                db.collection("users").document(user.email).updateData(["status": user.status])
            }
        }
        else {
            db.collection("history").document(user.name).setData(["currentRoom" : user.currentRoom!])
        }
    }
    
    
    //deletes a user from Firebase, admin only
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
                    var name = data["name"] as! String?
                    var email = data["email"] as! String?
                    let currentRoom = data["currentRoom"] as! String?
                    if name == nil {
                        name = "Not specified, please check Firebase"
                    }
                    if email == nil {
                        email = "Not specified, please check Firebase"
                    }
                    existingUsers.append(User(name: name!, email: email!, status: false, currentRoom: currentRoom))
                }
            }
            handler(existingUsers)
        }
    }

    //MARK: - Cleanup
    
    //func to sign out any existing sessions before app closes
    func endSessions(user: User) {
        if user.status == true {
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            user.endTime = currentDateTime
            
            let data: [String : Any] = ["name" : user.name, "room" : user.currentRoom!, "endTime" : user.endTime!]
            
            db.collection("history").document(user.email).collection("sessions").document("\(formatter.string(from: user.startTime!))").updateData(data)
            db.collection("users").document(user.email).updateData(["status": user.status])
        }
    }
} //end class

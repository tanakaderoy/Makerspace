//
//  UsersRealtimeDB.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/9/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

//import Foundation
//import Firebase
//import FirebaseDatabase
//
//class UsersRealtimeDB {
//    static let instance = UsersRealtimeDB()
//    init(){}
//    
//    let dbRef = Database.database().reference()
//    
//    func createUser(user: User) {
////        let keys = ["name" : user.name, "email" : user.email, "status" : user.status, "currentRoom" : user.currentRoom!] as [String : Any]
////        dbRef.childByAutoId().setValue(keys)
//        dbRef.child("users").childByAutoId().setValue(user.name)
//    }
//    
//    func retrieveUsers() {
//        dbRef.child("users").observe(.value) { (snapshot) in
//            let values = snapshot.value as? [String : Any] ?? [:]
//            let name = values["name"] as? String
//            let email = values["email"] as? String
//            let status = values["status"] as? Bool
//            let currentRoom = values["currentRoom"] as? String
//        }
//    }
//} //end class

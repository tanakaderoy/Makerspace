//
//  UserManager.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import Firebase

class UserManager {
    
    static let instance = UserManager()
    init(){}
    
    var users = [User]()
    
    var count: Int {
        return users.count
    }
    
    
    
    func createUser(name: String, email: String, status: Bool) {
        let newUser = User(name: name, email: email, status: status, badgeID: "test")
        UserNetworkAdaptor.instance.createFirebaseUser(user: newUser)                   //creates this user in the database!
        users.append(newUser)                                                           //append newUser to array of users
    }
    
    
    //returns array of all non-active users
    func nonActiveUsers(users: [User]) -> [User] {
        var nonActive = [User]()
        for user in users {
            if user.status == false {
                nonActive.append(user)
            }
        }
        return nonActive
    }
    
    
    //returns array of all active users
    func activeUsers(users: [User]) -> [User] {
        var active = [User]()
        for user in users {
            if user.status == true {
                active.append(user)
            }
        }
        return active
    }
    
    
    //updates the user status, updates database as well
    func updateUserStatus(user: User) {
        if user.status == true {
            UserNetworkAdaptor.instance.updateUserStatus(status: false, user: user)
            user.status = false
        }
        else {
            UserNetworkAdaptor.instance.updateUserStatus(status: true, user: user)
            user.status = true
        }
    }
    
    
    
} //end class 

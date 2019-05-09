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
    var delegate: UserManagerDelegate?
    
    //creates user in database, appends user to array of users
    func createUser(name: String, email: String, status: Bool, currentRoom: String?) {
        let newUser = User(name: name, email: email, status: status, currentRoom: currentRoom)
        UserNetworkAdaptor.instance.createFirebaseUser(user: newUser)
        users.append(newUser)
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
            user.status = false
            UserNetworkAdaptor.instance.updateUser(user: user)
        }
        else {
            user.status = true
            UserNetworkAdaptor.instance.updateUser(user: user)
        }
    }
    
    
    //closure communicating from network adaptor
    func loadUsers() -> [User] {
        let adaptor = UserNetworkAdaptor()
        adaptor.retrieveUsers { (users) in
            
            if let users = users {
                self.users.removeAll()
                self.users.append(contentsOf: users)
                self.delegate?.usersRetrieved()
            }
        }
        return users
    }
    
    
    //returns user at a selected index
    func getUserAtIndex(_ index: Int) -> User? {
        if index >= 0 && index < users.count {
            return users[index]
        }
        else {
            return nil
        }
    }
    
    
//    func populateTestUsers() -> [User] {
//        var testUsers = [User]()
//        let test1 = User(name: "Rob McMahon", email: "robert.mcmahon@otterbein.edu", status: false, currentRoom: "")
//        let test2 = User(name: "Charles Lashell", email: "charles.lashell@otterbein.edu", status: false, currentRoom: "")
//        let test3 = User(name: "Joe Test", email: "joetest@gmail.com", status: false, currentRoom: "")
//
//        testUsers.append(test1)
//        testUsers.append(test2)
//        testUsers.append(test3)
//        return testUsers
//    }
} //end class


//protocol
protocol UserManagerDelegate {
    func usersUpdated()
    func usersRetrieved()
}

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
    var realUsers = [User]()
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
                self.realUsers.removeAll()
                self.realUsers.append(contentsOf: users)
                self.delegate?.usersRetrieved()
            }
        }
        return realUsers
    }
    
    
    //returns user at a selected index
    func getUserAtIndex(_ index: Int) -> User? {
        if index >= 0 && index < realUsers.count {
            return realUsers[index]
        }
        else {
            return nil
        }
    }
    
    
    
    func populateRealUsers() {
        realUsers.append(User(name: "Amy Smith", email: "asmith@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Bailey Holcomb", email: "bailey.holcomb@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Travis Barr", email: "barr1@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Dustin Brugler", email: "brugler@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Connor Blair", email: "blair1@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Jill Connor", email: "centralohiowomenintrades@gmail.com", status: false, currentRoom: nil))
        realUsers.append(User(name: "Chad Stroud", email: "chad@engineered.vision", status: false, currentRoom: nil))
        realUsers.append(User(name: "Chad Galbraith", email: "charles.galbraith@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Curtis Smith", email: "csmith@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Dennis Blair", email: "dblair@blairit.com", status: false, currentRoom: nil))
        realUsers.append(User(name: "Alan Derikito", email: "derikito1@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Collin Hall", email: "hall3@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Isabella Majoros", email: "isabella.majoros@otterbein.edu", status: false, currentRoom: nil))
        realUsers.append(User(name: "Jordan Dun", email: "jordancdun1@gmail.com", status: false, currentRoom: nil))
        realUsers.append(User(name: "Joshua Klaehn", email: "joshua@path-robotics.com", status: false, currentRoom: nil))
        realUsers.append(User(name: "Josh Rowe", email: "jr108313@ohio.edu", status: false, currentRoom: nil))
        
        for user in realUsers {
            UserNetworkAdaptor.instance.createFirebaseUser(user: user)
        }
    }
    func createUser(name: String, email: String){
        let newUser = User(name: name, email: email, status: false, currentRoom: nil)
        UserNetworkAdaptor.instance.createFirebaseUser(user: newUser)
        //realUsers.append(newUser)
        realUsers = loadUsers()
        self.delegate?.usersRetrieved()
    }
} //end class


//protocol
protocol UserManagerDelegate {
    func usersUpdated()
    func usersRetrieved()
}

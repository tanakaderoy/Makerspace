//
//  User.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var email: String
    var status: Bool
    var currentRoom: String?
    
    
    init(name: String, email: String, status: Bool, currentRoom: String?) {
        self.name = name
        self.email = email
        self.status = status
        self.currentRoom = currentRoom
    }
    
} //end class

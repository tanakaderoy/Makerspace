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
        
        
    }
    
} //end class

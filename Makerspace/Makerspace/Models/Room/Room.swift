//
//  Room.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation

class Room {
    
    var roomName: String
    var totalUsers: Int
    var uniqueUsers: Int
    
    init(roomName: String, totalUsers: Int, uniqueUsers: Int) {
        self.roomName = roomName
        self.totalUsers = totalUsers
        self.uniqueUsers = uniqueUsers
    }
    
} //end class 

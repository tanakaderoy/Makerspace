//
//  Room.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//// Edited by Tanaka Mazivanhanga May 2019

import Foundation

class Room {
    
    var roomName: String
    var totalUsers: Int?
    var uniqueUsers: [String]
    
    
    init(roomName: String, totalUsers: Int, uniqueUsers: [String]) {
        self.roomName = roomName
        self.totalUsers = totalUsers
        self.uniqueUsers = uniqueUsers
    }
} //end class 

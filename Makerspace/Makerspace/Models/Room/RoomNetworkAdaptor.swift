//
//  RoomNetworkAdaptor.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/13/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation
import Firebase

class RoomNetworkAdaptor {
    
    static let instance = RoomNetworkAdaptor()
    init() {}
    
    
    //updates total users for the month, or until cleared
    func updateUsers(room: Room) {
        let values = ["totalUsers" : room.totalUsers!, "uniqueUsers" : room.uniqueUsers] as [String : Any]
        db.collection("rooms").document(room.roomName).setData(values as [String : Any])
    }
} //end class

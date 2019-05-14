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
        let values = ["Total Users" : room.totalUsers!, "Unique Users" : room.uniqueUsers] as [String : Any]
//        db.collection("rooms").document(room.roomName).setData(values as [String : Any])
        db.collection("rooms").document(room.roomName).updateData(values as [String : Any])
    }
    
    
    //closure communicating from Firebase to Network Adaptor
    func retrieveRooms(completionHandler handler: @escaping ([Room]?) -> Void) {
        var existingRooms = [Room]()
        db.collection("rooms").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting room data from Firestore: \(error)")
            }
            else {
                for room in snapshot!.documents {
                    let data = room.data()
                    
                    let users = data["Total Users"] as! Int
                    let unique = data["Unique Users"] as! [String]
                    existingRooms.append(Room(roomName: "meh", totalUsers: users, uniqueUsers: unique))
                }
            }
            handler(existingRooms)
        }
    }

} //end class

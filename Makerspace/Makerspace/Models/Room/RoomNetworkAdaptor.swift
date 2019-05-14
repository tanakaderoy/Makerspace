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
    var existingRooms = [Room]()
    
    
    
    //updates total users for the month, or until cleared
    func updateRooms(room: Room) {
        let values = ["Total Users" : room.totalUsers!, "Unique Users" : room.uniqueUsers] as [String : Any]
        db.collection("rooms").document(room.roomName).setData(values as [String : Any], merge: true)
    }
    
    
    //closure communicating from Firebase to Network Adaptor
    func retrieveRooms(completionHandler handler: @escaping ([Room]?) -> Void) {
        db.collection("rooms").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting room data from Firestore: \(error)")
            }
            else {
                for room in snapshot!.documents {
                    let data = room.data()

                    let name = data["Name"] as! String
                    let users = data["Total Users"] as! Int
                    let unique = data["Unique Users"] as! [String]
                    self.existingRooms.append(Room(roomName: name, totalUsers: users, uniqueUsers: unique))
                }
            }
            handler(self.existingRooms)
        }
    }
} //end class

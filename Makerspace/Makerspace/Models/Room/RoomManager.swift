//
//  RoomManager.swift
//  Makerspace
//
//  Created by Rob McMahon on 5/8/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import Foundation

class RoomManager {
    
    static let instance = RoomManager()
    init(){}
    
    var delegate: RoomManagerDelegate?
    let users = UserManager.instance.users
    var rooms = [Room]()
    
    
    let room1 = Room(roomName: "Design Studio", totalUsers: 0, uniqueUsers: [])
    let room2 = Room(roomName: "Rapid Prototyping", totalUsers: 0, uniqueUsers: [])
    let room3 = Room(roomName: "Wood Shop", totalUsers: 0, uniqueUsers: [])
    let room4 = Room(roomName: "Metal Shop", totalUsers: 0, uniqueUsers: [])
    let room5 = Room(roomName: "CNC Plasma", totalUsers: 0, uniqueUsers: [])
    let room6 = Room(roomName: "CNC Wood", totalUsers: 0, uniqueUsers: [])
    let room7 = Room(roomName: "CNC Tormach", totalUsers: 0, uniqueUsers: [])

    
    
    
    
    func populateRooms() -> [Room] {
        let rooms: [Room] = [room1, room2, room3, room4, room5, room6, room7]
        return rooms
    }
    
    
    //increments total users for a specified room
    func incrementTotalUsers(room: String) {
        for space in rooms {
            if space.roomName == room {
                space.totalUsers! += 1
                RoomNetworkAdaptor.instance.updateRooms(room: space)
            }
        }
    }
    
    
    //checks if user is unique before adding it
    func updateUniqueUsers(room: String, email: String) {
        for space in rooms {
            if space.roomName == room {
                if space.uniqueUsers.contains(email) {
                    return
                }
                else {
                    space.uniqueUsers.append(email)
                    RoomNetworkAdaptor.instance.updateRooms(room: space)
                }
            }
        }
    }
    
    
    //closure communicating from NetworkAdaptor to RoomManager
    func loadRooms() -> [Room] {
        let adaptor = RoomNetworkAdaptor()
        adaptor.retrieveRooms { (rooms) in
            if let rooms = rooms {
                self.rooms.removeAll()
                self.rooms.append(contentsOf: rooms)
                self.delegate?.roomsRetrieved()
            }
        }
        return rooms
    }
    
} //end class



protocol RoomManagerDelegate {
    func roomsRetrieved()
}

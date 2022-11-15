//
//  RoomManager.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class RoomManager {
    var rooms: [Room] = []
    
    func createRoom(roomName: String) -> RoomResult {
        guard !roomName.isEmpty else {
            return RoomResult(errorMessage: "Room can't be empty", room: nil)
        }
        for room in rooms {
            if room.name == roomName {
                return RoomResult(errorMessage: "Room is exist", room: nil)
            }
        }
        let room = Room(name: roomName, messages: [])
        rooms.append(room)
        return RoomResult(errorMessage: nil, room: room)
    }
    
    func getRoom(roomName: String) -> RoomResult {
        guard let room = rooms.first(where: { room in
            room.name == roomName
        }) else {
            return RoomResult(errorMessage: "Room does not exit", room: nil)
        }
        return RoomResult(errorMessage: nil, room: room)
    }
}



//
//  RoomManager.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-14.
//

import Foundation

struct RoomResult {
    let errorMessage: String?
    let room: Room?
}

class RoomManager {
    var rooms: [Room] = []
    
    func createRoom(roomName: String) -> RoomResult {
        guard !roomName.isEmpty else {
            return RoomResult(errorMessage: "empty id", room: nil)
        }
        
        for room in rooms {
            if room.name == roomName {
                return RoomResult(errorMessage: "Room name already exists", room: nil)
            }
        }
        
        let room =  Room(name: roomName, messages: [])
        rooms.append(room)
        return RoomResult(errorMessage: nil, room: room)
    }
    
    func getRoom(roomName: String) -> RoomResult {
        guard let room = rooms.first(where: { room in
            room.name == roomName
        }) else {
            return RoomResult(errorMessage: "Room does not exist", room: nil)
        }
        
        return RoomResult(errorMessage: nil, room: room)
    }
}

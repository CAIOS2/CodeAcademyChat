//
//  RoomManager.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-08.
//

import Foundation

struct RoomResult {
    let errorMessage: String?
    let room: Room?
    
    
}

class RoomManager {
    var rooms: [Room] = [Room(name: "1", onlineUsers: [], offlineUsers: [], messageHistory: [], message: [])]

    
    func createRoom(roomName: String) -> RoomResult {
        guard !roomName.isEmpty else {
            return RoomResult(errorMessage: "Please enter room name!", room: nil)
        }
        
        for room in rooms {
            if room.name == roomName {
                return RoomResult(errorMessage: "Room name already used", room: nil)
            }
        }
        
        let room = Room(name: roomName, onlineUsers: [], offlineUsers: [], messageHistory: [], message: [])
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

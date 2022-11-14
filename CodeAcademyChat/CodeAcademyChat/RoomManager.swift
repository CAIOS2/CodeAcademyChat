//
//  RoomManager.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-08.
//

import Foundation

struct RoomResult {
    let errorMessage: String?
    let room: Room?
}

class RoomManager {
    var propertyRooms: [Room] = []
    
    init() {
        
    }
    
    func createRoom(parameterRoomName: String) -> RoomResult {
        guard !parameterRoomName.isEmpty else {
            return RoomResult(errorMessage: "empty id", room: nil)
        }
        
        for eachRoom in propertyRooms {
            if eachRoom.name == parameterRoomName {
                return RoomResult(errorMessage: "Room name already exists", room: nil)
            }
        }
        
        let resultRoom = Room(name: parameterRoomName, messages: [])
        
        propertyRooms.append(resultRoom)
        return RoomResult(errorMessage: nil, room: resultRoom)
    }
    
    func getRoom(roomName: String) -> RoomResult {
        guard let room = propertyRooms.first(where: { room in
            room.name == roomName
        }) else {
            return RoomResult(errorMessage: "Room does not exist", room: nil)
        }
        
        return RoomResult(errorMessage: nil, room: room)
    }
}

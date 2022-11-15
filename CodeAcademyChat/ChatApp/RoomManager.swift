//
//  RoomManager.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class RoomManager {
    var property_rooms: [Room] = []
    
    func createRoom(parameter_roomName: String) -> RoomResult {
        guard !parameter_roomName.isEmpty else {
            return RoomResult(errorMessage: "Room can't be empty", room: nil)
        }
        for each_room in property_rooms {
            if each_room.name == parameter_roomName {
                return RoomResult(errorMessage: "Room is exist", room: nil)
            }
        }
        let resultRoom = Room(name: parameter_roomName, messages: [])
        property_rooms.append(resultRoom)
        return RoomResult(errorMessage: nil, room: resultRoom)
    }
    
    func getRoom(parameter_roomName: String) -> RoomResult {
        guard let room = property_rooms.first(where: { room in
            room.name == parameter_roomName
        }) else {
            return RoomResult(errorMessage: "Room does not exit", room: nil)
        }
        return RoomResult(errorMessage: nil, room: room)
    }
}



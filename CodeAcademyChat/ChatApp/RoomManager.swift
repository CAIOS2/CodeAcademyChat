//
//  RoomManager.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class RoomManager {
    var rooms: [Room] = []
    
    func getRoom(roomName: String) -> RoomResult {
        guard let room = rooms.first(where: { room in
            room.name == roomName
        }) else {
            return RoomResult(errorMessage: "Room does not exit", room: nil)
        }
        return RoomResult(errorMessage: nil, room: room)
    }
}



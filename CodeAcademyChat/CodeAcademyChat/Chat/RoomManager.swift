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
    var rooms: [Room] = []
    
    
    func createRoom(){
        
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

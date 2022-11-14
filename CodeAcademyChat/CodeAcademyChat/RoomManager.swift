//
//  RoomManager.swift
//  CodeAcademyChat
//
//  Created by Dmitrij Aneicik on 2022-11-14.
//

import Foundation

struct RoomResult {
    let room: Room?
    let errorMessage: String?
}

class RoomManager {
    var rooms = [Room]()
    
    func createRoom (roomName: String) -> RoomResult {
        
        guard !roomName.isEmpty else {  return RoomResult(room: nil, errorMessage: "empty id" )}
        
        guard rooms.first(where: {$0.roomName == roomName}) != nil else {
            return RoomResult(room: nil, errorMessage: "Room name already exists")
        }
        
        
    }
 
}

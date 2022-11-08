//
//  RoomManager.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-08.
//

import Foundation

class RoomManager {
    
    // grazinimui pranesimu apie sukurima/ gavima
    struct RoomResult {
        let room: Room?
        let errorMessage: String?
    }
    
    var roomList: [Room] = []
    var loggedUserName: User!
    
    
    // add new room
    func addRoom(newName: String) -> RoomResult {
        
        guard !newName.isEmpty
                && !roomList.contains(where: {$0.name == newName.lowercased()})
        else {
            return RoomResult(room: nil,
                              errorMessage: "Sorry, but with these id was created earlier")
        }
        let newRoom = Room(name: newName.lowercased(), onlineUsers: [loggedUserName], offlineUsers: [], messageHistory: [], message: [])
        roomList.append(newRoom)
        return RoomResult(room: newRoom, errorMessage: "")
    }
    
    
    // get room by name
    func getRoom(name: String) -> RoomResult {
        
        guard let room = roomList.first(where: { room in
            room.name == name
        }) else {
            return RoomResult(room: nil, errorMessage: "Can't find room")
        }
        
        
        return RoomResult(room: room, errorMessage: nil)
    }
    
    
    
    
    
}


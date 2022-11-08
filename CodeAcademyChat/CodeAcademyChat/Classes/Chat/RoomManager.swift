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
        let id: Room?
        let errorMessage: String?
    }
    
    var roomList: [Room] = []
    
    func addRoom(newID: String) -> RoomResult {
        
        guard !newID.isEmpty
                && !roomList.contains(where: {$0.id == newID.lowercased()})
        else {
            return RoomResult(id: nil, errorMessage: "Sorry, but with these id was created earlier")
        }
        
        var datetime = NSDate()
        let newRoom = Room(datetime: datetime as Date, id: newID)
        
        
        
        // todo, fix return
        return RoomResult(id: nil, errorMessage: "")
    }
    
    
    
    
    
    
    
}


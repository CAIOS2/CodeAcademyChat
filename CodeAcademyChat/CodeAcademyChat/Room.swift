//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Dmitrij Aneicik on 2022-11-14.
//

import Foundation

class Room {
    
    var roomName: String
    var messages: [Message]?
    
    init(roomName: String) {
        self.roomName = roomName
    }
}

//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-14.
//

import Foundation

class Room {
    let name: String
    var messages: [Message]
    
//    init(name: String, onlineUsers: [User], offlineUsers: [User], messageHistory: [Message], messages: [Message]) {
//        self.name = name
//        self.onlineUsers = onlineUsers
//        self.offlineUsers = offlineUsers
//        self.messageHistory = messageHistory
//        self.messages = messages
//    }
    
    init(name: String, messages: [Message]) {
        self.name = name
        self.messages = messages
    }
}

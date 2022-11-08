//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-08.
//

import Foundation


class Room {
    let name: String
    let onlineUsers: [User]
    var offlineUsers: [User]
    let messages: [Message]
    let messagesHistory: [Message]
    
    init(name: String, onlineUsers: [User], offlineUsers: [User], messages: [Message], messagesHistory: [Message]) {
        self.name = name
        self.onlineUsers = onlineUsers
        self.offlineUsers = offlineUsers
        self.messages = messages
        self.messagesHistory = messagesHistory
    }
}

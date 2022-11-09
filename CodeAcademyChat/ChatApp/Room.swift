//
//  Room.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class Room {
    let name: String
    var onlineUsers: [User]
    var offlineUsers: [User]
    var messageHistory: [Message]
    var messages: [Message]
    
    init(name: String, onlineUsers: [User], offlineUsers: [User], messageHistory: [Message], messages: [Message]) {
        self.name = name
        self.onlineUsers = onlineUsers
        self.offlineUsers = offlineUsers
        self.messageHistory = messageHistory
        self.messages = messages
    }
}

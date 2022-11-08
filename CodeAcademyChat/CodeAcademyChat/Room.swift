//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-08.
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

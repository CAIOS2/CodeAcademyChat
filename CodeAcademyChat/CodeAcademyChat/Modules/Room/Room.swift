//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-08.
//

import Foundation

class Room {
    
    let name: String
    let onlineUsers: [User]
    let offlineUsers: [User]
    let messageHistory: [Message]
    var messages: [Message]
    
    init(name: String, onlineUsers: [User], offlineUsers: [User], messageHistory: [Message], message: [Message]) {
        self.name = name
        self.onlineUsers = onlineUsers
        self.offlineUsers = offlineUsers
        self.messageHistory = messageHistory
        self.messages = message
    }
    
    func writeMessage(messageContent: String, sender: User) {
        
        let message = Message(content: messageContent, date: .now, username: sender.username)
        messages.append(message)
        
    }
}

//
//  Room.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-08.
//

import Foundation

class Room {
    let name: String
    //    var onlineUsers: [User]
    //    var offlineUsers: [User]
    //    var messageHistory: [Message]
    var messages: [Message]
    
    init(name: String,
         //         onlineUsers: [User],
         //         offlineUsers: [User],
         //         messageHistory: [Message],
         messages: [Message]) {
        self.name = name
        //        self.onlineUsers = onlineUsers
        //        self.offlineUsers = offlineUsers
        //        self.messageHistory = messageHistory
        self.messages = messages
    }
    
    func writeMessage(messageContent: String, sender: User) {
        var message = Message(datetime: .now, username: sender.username, content: messageContent)
        messages.append(message)
    }
    
    func getMessages() -> [String] {
        
        guard  messages.count > 0 else {
            return []
        }
        var messageList: [String] = []
        
        for message in messages {
            let messageContent = message.content
            messageList.append(messageContent)
        }
        return messageList
    }
    
    
}


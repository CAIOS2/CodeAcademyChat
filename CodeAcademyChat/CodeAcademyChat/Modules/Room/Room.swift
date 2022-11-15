//
//  Room.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-08.
//

import Foundation


class Room {
    let name: String
    var messages: [Message]
    
    init(name: String, messages: [Message]) {
        self.name = name
        self.messages = messages
    }
    func writeMessage(messageContent: String, sender: User) {
        var message = Message(content: messageContent, date: .now, username: sender.username)
                messages.append(message)
    }
}

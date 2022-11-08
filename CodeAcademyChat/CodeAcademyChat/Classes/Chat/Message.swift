//
//  Message.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-08.
//

import Foundation

class Message {
    let datetime: Date
    let user: String
    let roomID: String
    let content: String
    
    init(datetime: Date, user: String, roomID: String, content: String) {
        self.datetime   = datetime
        self.user       = user
        self.roomID     = roomID
        self.content    = content
    }
}


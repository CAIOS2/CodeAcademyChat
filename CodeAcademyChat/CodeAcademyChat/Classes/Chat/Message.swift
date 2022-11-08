//
//  Message.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-08.
//

import Foundation

class Message {
    let datetime: Date
    let username: String
    let content: String
    
    init(datetime: Date, username: String, content: String) {
        self.datetime   = datetime
        self.username   = username
        self.content    = content
    }
}


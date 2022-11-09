//
//  Message.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-08.
//

import Foundation


class Message {
    
    var content: String
    let date: Date
    let userName: String
    
    
    init(content: String, date: Date, userName: String)
    {
        self.content = content
        self.date = date
        self.userName = userName
    }
}

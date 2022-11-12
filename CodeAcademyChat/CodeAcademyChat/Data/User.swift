//
//  User.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-07.
//

import Foundation

class User {
    
    let username: String
    
    var password: String
    
    var isOnline: Bool
    
    init (username: String, password: String, isOnline: Bool) {
        self.username = username
        self.password = password
        self.isOnline = isOnline
        
    }
}


//
//  User.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import Foundation

class User {
    var username: String
    let password: String
    let isOnline: Bool
    
    init(username: String, password: String, isOnline: Bool) {
        self.username = username
        self.password = password
        self.isOnline = isOnline
    }
}

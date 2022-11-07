//
//  User.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-07.
//

import Foundation

class User {
    let username: String
    let password: String
    var isOnline: Bool
    
    init(username: String, password: String, isOnline: Bool) {
        self.username = username
        self.password = password
        self.isOnline = isOnline
    }
}

let userioObjektas = User(username: "Romas", password: "123", isOnline: true)

//
//  User.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-07.
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
//test commit
//let userioObjektas = User(username: "romas", password: "123", isOnline: true)

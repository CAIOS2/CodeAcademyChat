//
//  User.swift
//  CodeAcademyChat
//
//  Created by Linas Nutautas on 07/11/2022.
//

import Foundation

class User {
    let username: String
    let password: String
    var activate: Bool
    
    init(username: String, password: String, activate: Bool) {
        self.username = username
        self.password = password
        self.activate = activate
    }
    
}

//Klases kurimo funkcija
//let userioObjektas = User(username: "linas", password: "123", activate: true)

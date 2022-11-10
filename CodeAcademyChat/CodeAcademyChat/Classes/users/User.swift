//
//  User.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-07.
//

import Foundation


class User {
    var username: String
    var password: String
    var isOnline: Bool
 
    init(username: String, password: String, isOnline: Bool) {
        self.username = username
        self.password = password
        self.isOnline = isOnline
    }


}

//let userObject = User(username: "gedas", password: "afrika", isOnline: true)





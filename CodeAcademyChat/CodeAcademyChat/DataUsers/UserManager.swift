//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-07.
//

import Foundation

class UserManager {
    var userList: [User] = []
    func register(username: String, password: String, confirmPassword: String) {
        
        guard !username.isEmpty, !password.isEmpty
        else {
            return
        }
        if password != confirmPassword {
            return
        }

        for user in userList {
            if username == user.username {
                return
            }
        }
        
        let user = User(username: username, password: password, isOnline: true)
        
        userList.append(user)
    }
}




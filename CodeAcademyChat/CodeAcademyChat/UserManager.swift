//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-07.
//

import Foundation

struct RegisterResult {
    let user: User?
    let errorMessage: String?
}

class UserManager {
    var userList: [User] = []
    
    func register(username: String, password: String, confirmPassword: String) -> RegisterResult {
        guard !username.isEmpty, !password.isEmpty
        else {
            return RegisterResult(user: nil, errorMessage: "User name and password cannot be empty")
        }
        if password != confirmPassword {
            return RegisterResult(user: nil, errorMessage: "Passwords do not match")
        }

        for user in userList {
            if username == user.username {
                return RegisterResult(user: nil, errorMessage: "User already exists")
            }
        }
        
        let user = User(username: username, password: password, isOnline: true)
        
        userList.append(user)
        
        return RegisterResult(user: user, errorMessage: nil)
    }
}



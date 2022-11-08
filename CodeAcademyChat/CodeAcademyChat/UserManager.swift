//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-07.
//

import Foundation

struct UserResult {
    let user: User?
    let errorMessage: String?
}

class UserManager {
    var userList: [User] = []
    
    func register(username: String, password: String, confirmPassword: String) -> UserResult {
        guard !username.isEmpty, !password.isEmpty
        else {
            return UserResult(user: nil, errorMessage: "User name and password cannot be empty")
        }
        if password != confirmPassword {
            return UserResult(user: nil, errorMessage: "Passwords do not match")
        }
        
        for user in userList {
            if username == user.username {
                return UserResult(user: nil, errorMessage: "User already exists")
            }
        }
        
        let user = User(username: username, password: password, isOnline: true)
        
        userList.append(user)
        
        return UserResult(user: user, errorMessage: nil)
    }
    
    func login(username: String, password: String) -> UserResult {
        
        if let user = userList.first(where: {$0.username == username}) {
            
            if password == user.password {
                
                return UserResult(user: user, errorMessage: nil)
            }
        }
        
        return UserResult(user: nil, errorMessage: "No user \(username) found")
    }
}

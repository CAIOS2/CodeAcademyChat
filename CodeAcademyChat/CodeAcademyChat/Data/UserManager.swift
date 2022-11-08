//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import Foundation

struct RegisterResult {
    let user: User?
    let errorMessage: String?
}

struct LoginResult {
    let isLogin: Bool?
    let errorMessage: String?
}

class UserManager {
    
    var userList: [User] = []
    func register(username: String, password: String, confirmPassword: String) -> RegisterResult {
        guard !username.isEmpty, !password.isEmpty
        else {
            return RegisterResult(user: nil, errorMessage: "User and password cannot be empty")
        }
        
        if password != confirmPassword {
            return RegisterResult(user: nil, errorMessage: "Password do not match")
        }
        for i in userList {
            if username == i.username {
                return RegisterResult(user: nil, errorMessage: "User already exists")
                
            }
        }
       let userObject = User(username: username, password: password, isOnline: true)
        userList.append(userObject)
        return RegisterResult(user: nil, errorMessage: nil)
    }
    
    func login(username: String, password: String) -> LoginResult {
        for i in userList {
            if username == i.username && password == i.password {
                return LoginResult(isLogin: true, errorMessage: nil)
            }
        }
        return LoginResult(isLogin: nil, errorMessage: "Incorrect username or password.")
    }
}

//
//  UserManager.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class UserManager {
    var userList: [User] = []
    
    func registration(username: String, password: String, confirmPassword: String) -> UserResult {
        let registerErrorTitle = "Error creating user"
        guard !username.isEmpty, !password.isEmpty else {
            return UserResult(user: nil,errorTitle: registerErrorTitle, errorMessage: "Username and password cannot be empty")
        }
        if password != confirmPassword {
            return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "Passwords do not match")
        }
        for user in userList {
            if username == user.name {
                return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "User is already exists")
            }
        }
        let user = User(name: username, password: password, isOnline: true)
        userList.append(user)
        return UserResult(user: user, errorTitle: nil, errorMessage: nil)
    }
    
    func login(username: String, password: String) -> UserResult {
        let loginErrorTitle = "Error logged in"
        let userOptional = userList.first { user in
            user.name == username
        }
        guard let user = userOptional else {
            return UserResult(user: nil, errorTitle: loginErrorTitle, errorMessage: "User with given username not found")
        }
        if user.password != password {
            return UserResult(user: nil, errorTitle: loginErrorTitle, errorMessage: "Entered password is wrong")
        }
        return UserResult(user: user, errorTitle: loginErrorTitle, errorMessage: nil)
    }
}

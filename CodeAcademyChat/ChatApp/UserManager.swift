//
//  UserManager.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class UserManager {
    var property_userList: [User] = []
    
    func registration(parameter_username: String, parameter_password: String, parameter_confirmPassword: String) -> UserResult {
        let registerErrorTitle = "Error creating user"
        guard !parameter_username.isEmpty, !parameter_password.isEmpty else {
            return UserResult(user: nil,errorTitle: registerErrorTitle, errorMessage: "Username and password cannot be empty")
        }
        if parameter_password != parameter_confirmPassword {
            return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "Passwords do not match")
        }
        for user in property_userList {
            if parameter_username == user.name {
                return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "User is already exists")
            }
        }
        let user = User(name: parameter_username, password: parameter_password, isOnline: true)
        property_userList.append(user)
        return UserResult(user: user, errorTitle: nil, errorMessage: nil)
    }
    
    func login(username: String, password: String) -> UserResult {
        let loginErrorTitle = "Error logged in"
        let userOptional = property_userList.first { user in
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

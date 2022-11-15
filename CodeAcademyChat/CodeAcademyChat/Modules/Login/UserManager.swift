//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-07.
//

import Foundation

struct UserResult {
    let user: User?
    let errorTitle: String?
    let errorMessage: String?
}

class UserManager {    
    var userList: [User] = [
        User(username: "romas", password: "12345", isOnline: false),
        User(username: "petras", password: "12345", isOnline: false)]
    
    func register(username: String, password: String, confirmPassword: String) -> UserResult {
        let registerErrorTitle = "Error creating user"
        
        guard !username.isEmpty, !password.isEmpty
        else {
            return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "User name and password cannot be empty")
        }
        if password != confirmPassword {
            return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "Passwords do not match")
        }

        for user in userList {
            if username == user.username {
                return UserResult(user: nil, errorTitle: registerErrorTitle, errorMessage: "User already exists")
            }
        }
        
        let user = User(username: username, password: password, isOnline: true)
        
        userList.append(user)
        
        return UserResult(user: user, errorTitle: nil, errorMessage: nil)
    }
    
    func arPetras(user: User) -> Bool {
        return user.username == "petras"
    }
    
    func login(username: String, password: String) -> UserResult {
        let loginErrorTitle = "Error logged in"
        /* pirmas variantas */
        let userOptional = userList.first { user in
            user.username == username
        }
        
        /* pvz kaip paduodam funkcija vietoj closure */
//        let userOptional = userList.first(where: arPetras)
        
        /* antras variantas */
        /*
        let userOptional = userList.first(where: { $0.username == username })
         */
        
        
        guard let user = userOptional else {
            return UserResult(user: nil, errorTitle: loginErrorTitle, errorMessage: "User with given username not found")
        }
        
        if user.password != password {
            return UserResult(user: nil, errorTitle: loginErrorTitle, errorMessage: "Entered password is wrong")
        }
        
        return UserResult(user: user, errorTitle: loginErrorTitle, errorMessage: nil)
    }
}

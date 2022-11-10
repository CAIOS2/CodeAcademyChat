//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import Foundation

struct UserResult {
    let user: User?
    let errorMessage: String?
    let isLogin: Bool?
}


class UserManager {
    
    var userList: [User] = [User(username: "Nikita", password: "12345", isOnline: false)]
    
    func register(username: String, password: String, confirmPassword: String) -> UserResult {
        guard !username.isEmpty, !password.isEmpty
        else {
            return UserResult(user: nil, errorMessage: "User and password cannot be empty", isLogin: nil)
        }
        
        if password != confirmPassword {
            return UserResult(user: nil, errorMessage: "Password do not match", isLogin: nil)
        }
        for i in userList {
            if username == i.username {
                return UserResult(user: nil, errorMessage: "User already exists", isLogin: nil)
                
            }
        }
        let userObject = User(username: username, password: password, isOnline: true)
        userList.append(userObject)
        return UserResult(user: nil, errorMessage: nil, isLogin: nil)
    }
    
//        func login(username: String, password: String) -> LoginResult {
//            for i in userList {
//                if username == i.username && password == i.password {
//                    return LoginResult(isLogin: true, errorMessage: nil)
//                }
//            }
//            return LoginResult(isLogin: nil, errorMessage: "Incorrect username or password.")
//        }
    
    func login(username: String, password: String) -> UserResult {
        let userOptional = userList.first { user in
            user.username == username
        }
//        let userOptiona = userList.first(where: { $0.username == username})
        guard let user = userOptional else {
            return UserResult(user: nil, errorMessage: "User with given username not found", isLogin: nil)
        }
        
        if user.password != password {
            return UserResult(user: nil, errorMessage: "Entered password is wrong", isLogin: nil)
        }
        return UserResult(user: user, errorMessage: nil, isLogin: nil )
    }
    
    func editNickname(username: String, confirmUsername: String) -> UserResult{
        guard username == confirmUsername else {
            return UserResult(user: nil, errorMessage: "usernames do not match", isLogin: nil)
        }
        
//        if let index = userList.firstIndex(of: e) {
//            //index has the position of first match
//        } else {
//            //element is not present in the array
//        }
        
        return UserResult(user: nil, errorMessage: nil, isLogin: nil)
    }
}

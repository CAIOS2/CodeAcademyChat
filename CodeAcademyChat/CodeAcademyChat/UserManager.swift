//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by Linas Nutautas on 07/11/2022.
//

import Foundation


class UserManager {
    var userList: [User] = []
    func registration(username: String, password: String, comfirmPasword: String) {
        guard !username.isEmpty, !password.isEmpty else {
            return
        }
        if password != comfirmPasword {
            return
        }
        for user in userList {
            if username == user.username {
                return
            }
        }
        
        let user = User(username: username, password: password, activate: true)
        userList.append(user)
    }
}


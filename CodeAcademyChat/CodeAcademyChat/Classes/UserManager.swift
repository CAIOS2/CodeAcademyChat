//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-07.
//

import Foundation

class UserManager {
    
    var userList: [User] = []
    
    func addNewUser(username: String, password: String, confirmPassword: String) {
        
        guard !username.isEmpty
                && !password.isEmpty
                && password == confirmPassword
                && !userList.contains(where: {$0.username == username})
        else {
            return
        }
        
        // variantas 2, kai patikrinti ar username yra sarase
//        for user in userList {
//            if user.username == username {
//                return  // po sio return baigiasi funkcija
//            }
//        }
        // sukuriame user objekta
        let newUser = User(username: username, password: password, isOnline: true)
        // prideda user objekta i sarasa
        userList.append(newUser)
    }
    
}


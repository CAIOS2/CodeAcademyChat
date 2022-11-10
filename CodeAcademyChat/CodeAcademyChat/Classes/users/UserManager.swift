//
//  UserManager.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-07.
//

import Foundation

class UserManager {
    
    struct UserResult {
        let user: User?
        let errorMessage: String?
    }
    
    
    
    var userList: [User] = []
    

    
    // -- -- --
    // New User
    func addNewUser(username: String, password: String, confirmPassword: String) -> UserResult {  // ? nes galime ir negrazinti err.
        
        guard !username.isEmpty
                && !password.isEmpty
                && password == confirmPassword
                && !userList.contains(where: {$0.username == username})
        else {
            return UserResult(user: nil, errorMessage: "Something wrong in registration data")
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
        
        //print(userList)
        //print("New user: \(newUser.username), \(newUser.password)")

        
        return UserResult(user: newUser, errorMessage: nil)
    }
    

    
    
    
    // -- -- --
    // LOGIN
    func userLogin(username: String, password: String) -> UserResult  {
        
        // just for test
        let gedas = User(username: "gedas", password: "gk", isOnline: true)
        userList.append(gedas)
        
        
        if let login = userList.first(where: {$0.username == username && $0.password == password}) {
            login.isOnline = true
            print("Logged in: \(login.username), \(login.password)")
           // return true
            return UserResult(user: login, errorMessage: nil)
        }
        
//        for user in userList {
//            if user.username == username
//                && user.password == password {
//                user.isOnline = true
//                print("Logged in: \(user.username), \(user.password)")
//                return true
//
//            }
//        }

       // return false
        return UserResult(user: nil, errorMessage: "No user found")
    }
    
    
    func getUserList() {
        print("\n Whole user qnt: \(userList.count)")
        for user in userList {
            print("Whole user list: \(user.username), \(user.password), \(user.isOnline)")
        }
    }
    
    
}




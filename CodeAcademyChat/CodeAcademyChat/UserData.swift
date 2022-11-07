//
//  UserData.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-05.
//

import Foundation

struct UserLoginData: Decodable, Encodable {
    let uuid: String
    var username: String
    var passwordHash: String
}

class UserData {
    static let defaults = UserDefaults.standard
    
    /// Returns new user struct with required data
    private func createNewUser(username: String, password: String) -> UserLoginData {
        return UserLoginData(
            uuid: UUID().uuidString,
            username: username,
            passwordHash: Hashing.hash(password)
        )
    }
    
    /// Returns user by username from given list or from list saved in UserDefaults
    private func findUser(username: String, _ usersList: [UserLoginData]? = nil) -> UserLoginData? {
        if let users: [UserLoginData] = usersList {
            return findUserInList(username: username, users)
        }
        if let users: [UserLoginData] = getUsers() {
            return findUserInList(username: username, users)
        }
        return nil
        
    }
    
    /// Returns  user by username from given list
    private func findUserInList(username: String, _ usersList: [UserLoginData]) -> UserLoginData? {
        for each in usersList {
            if each.username == username {
                return each
            }
        }
        return nil
    }
    
    /// Returns users from UserDefaults
    private func getUsers() -> [UserLoginData]? {
        var jFromDefault: String = ""
        
        if let j = UserData.defaults.string(forKey: "usersLoginData") {
            jFromDefault = j
        }
        print(jFromDefault)
        
        let userDataFromDefaults: [UserLoginData]? = instantiate(
            jsonString: jFromDefault
        )
        
        if let usersArray = userDataFromDefaults {
            return usersArray
        }
        
        return nil
    }
    
    /// Creates a new user to UserDefaults
    func addUser(username: String, password: String) -> String? {
        var userList: [UserLoginData] = []
        if let users = getUsers() {
            if findUser(username: username, users) != nil {
                // user with such username exists
                return nil
            }
            userList = users
        }
        let newUser = createNewUser(username: username, password: password)
        userList.append(newUser)
        
        let jsonString = userList.toJSONString()
        print(jsonString)
        UserData.defaults.set(jsonString, forKey: "usersLoginData")
        return username
    }
    
    /// Returns user username if such user exist and passwords match
    func loginUser(username: String, password: String) -> String? {
        if let userSaved = findUser(username: username) {
            if Hashing.verify(hash: userSaved.passwordHash, password: password) {
                return userSaved.username
            }
        }
        return nil
    }
    
}

extension Encodable {
    func toJSONString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
    
}
func instantiate<T: Decodable>(jsonString: String) -> T? {
    return try? JSONDecoder()
    .decode(T.self, from: jsonString.data(using: .utf8)!)
}

//
//  DataManager.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation
import CryptoKit

// User logs in
// Join room - search for room name (ID)
    // search for all messages to that room
// Create new room - create new room
// Show online users - get online users and rooms in which they are online
// Show offline users - get offline users and rooms in which they are offline
// Settings
    // username can change
    // password can change
    // get all messages of that user


/*
 One data manager would be able to store user data like:
    username
    password
    rooms
        messages
        minimal data on users
        key
    keys to rooms
    
 */
struct ShortUserAccount {
    let uuid: String
    let username: String
    var online: Bool
    let passwordHash: String
    // wib?
}

class DataManager {
    var storage: Storage
    // created on user login and be updated while use
    var currentUsername: String? = nil
    var currentPassword: String? = nil
    
    var user: UserData? = nil
    var rooms: [Room]? = nil
    
    var shortUserAccounts: [ShortUserAccount]? = nil
    
    var roomUUIDKeyPair: [(String, SymmetricKey)]? = nil
    
    // user enters application
    init() {
        self.storage = Storage()
        // get user
        // get users (minimal)
        // get rooms of user
        // get messages of requested room
    }
    
    // user logs in
    
    /// Obtain user data from UD
    /// 0 - username, 1 - password
    func getLoginFromSavedData() throws {
        if let loggedInUser = self.storage.getUserLoginData() {
            try login(username: loggedInUser.0, password: loggedInUser.1)
        }
    }
    
    /// Load shorted user data in list to shortUserAccounts
    /// Contains username and password hash
    func loadShortUsers() throws {
        var res = self.storage.get(by: "user")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        
        let users = res.data as! [UserData]

        var list: [ShortUserAccount] = []
        for user in users {
            list.append(
                ShortUserAccount(uuid: user.uuid, username: user.username, online: user.online, passwordHash: user.passwordHash)
            )
        }
        self.shortUserAccounts = list
    }
    
    func login(username: String, password: String) throws {
        let user = try UserData(by: username, from: self.storage)
        if Hashing.verify(hash: user.passwordHash, password: password) {
            self.currentPassword = password
            self.currentUsername = username
            self.user = user
        }
    }
    
    // User must be able to be found to login
    // User must obtain rooms with messages, after log in
    // User must see users status, that are joined in the same rooms
    // User must be able to create new room
    // User must be able to view all messages that were written only by the user
}

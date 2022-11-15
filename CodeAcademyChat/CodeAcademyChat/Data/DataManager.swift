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
    var roomsAndKeys: [(Room, SymmetricKey)]? = nil
    
    var onlineUsers: [RoomUser]? = nil
    var offlineUsers: [RoomUser]? = nil
    
    var shortUserAccounts: [ShortUserAccount]? = nil
    
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
        let res = self.storage.get(by: "user")
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
    
    func getOnlineOfflineUsers() {
        var savedUsers: [RoomUser] = []
        
        // check every room
        for each in self.roomsAndKeys! {
            // check for every user in room
            for every in each.0.users! {
                var toAdd = true
                // check if user is in savedUsers
            savedUsers: for one in savedUsers {
                    if one.username == every.username {
                        toAdd = false
                        break savedUsers
                    }
                }
                if toAdd {
                    savedUsers.append(every)
                }
            }
        }
        
        // collect online/offline users
        var onlineUsers: [RoomUser] = []
        var offlineUsers: [RoomUser] = []
        
        for each in savedUsers {
            if each.online {
                onlineUsers.append(each)
            } else {
                offlineUsers.append(each)
            }
        }
        // set to self
        self.onlineUsers = onlineUsers
        self.offlineUsers = offlineUsers
    }
    
    func login(username: String, password: String) throws {
        let user = try UserData(by: username, from: self.storage)
        if Hashing.verify(hash: user.passwordHash, password: password) {
            self.currentPassword = password
            self.currentUsername = username
            self.user = user
            let roomDataAndKeys: [(RoomData, SymmetricKey)] = try self.user!.getAllRooms(from: storage, password: password)
            var roomsAndKeys: [(Room, SymmetricKey)] = []
            for each in roomDataAndKeys {
                let room = Room(each.0.self)
                try room.load(in: storage, decrypting: each.1)
                roomsAndKeys.append((room, each.1))
            }
            self.roomsAndKeys = roomsAndKeys
            getOnlineOfflineUsers()
            self.storage.setUserLoginData(username: username, password: password)
        }
    }
    
    func logout() {
        self.storage.removeUserLoginData()
    }
    
    // User must be able to be found to login
    // User must obtain rooms with messages, after log in
    // User must see users status, that are joined in the same rooms
    // User must be able to create new room
    // User must be able to view all messages that were written only by the user
}

//
//  DataManager.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

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

struct ShortUserAccount {
    let uuid: String
    let username: String
    var online: Bool
    let passwordHash: String
}

let sharedDataManager = DataManager()

class DataManager {
    
    var storage: Storage
    // created on user login and be updated while use
    var currentUsername: String? = nil
    var currentRoom: Room? = nil
    
    var user: UserData? = nil
    var userJoinedRooms: [Room]? = nil
    
    var onlineUsers: [RoomUser]? = nil
    var offlineUsers: [RoomUser]? = nil
    
    // user enters application
    init() {
        self.storage = Storage()
    }
    
    /// Obtain user data from UD
    func getLoginFromSavedData() -> Bool {
        if let loggedInUser = self.storage.getUserLoginData() {
            do {
                try login(username: loggedInUser.0, password: loggedInUser.1)
                return true
            } catch let e as NSError {
                if e.domain == "Wrong password" {
                    return false
                }
                return false
            }
        }
        return false
    }
    
    func updateRoomData(data: RoomData) {
        if self.userJoinedRooms == nil {
            self.userJoinedRooms = [Room(data)]
        } else {
            self.userJoinedRooms!.append(Room(data))
        }
    }
    
    func getOnlineOfflineUsers() {
        
        if let rooms = storage.get(by: "room") as? [RoomData] {
            if let users = storage.get(by: "user") as? [UserData] {
                
                var usersList: [UserData] = []
                var roomJoinedByUser: [RoomData] = []
                
                // in each room
                for each in rooms {
                    for uuid in each.usersUUIDs {
                        // check if current user in in the room
                        if uuid == sharedDataManager.user!.uuid {
                            roomJoinedByUser.append(each)
                            break
                        }
                    }
                }
                
                for each in roomJoinedByUser {
                    
                    for uuid in each.usersUUIDs {
                        var isUserInList = false
                        for userInList in usersList {
                            if userInList.uuid == uuid {
                                isUserInList = true
                                break
                            }
                        }
                        if !isUserInList {
                            for user in users {
                                if user.uuid == uuid {
                                    usersList.append(user)
                                    break
                                }
                            }
                        }
                    }
                }
                
                var onlineUsers: [RoomUser] = []
                var offlineUsers: [RoomUser] = []
                
                for each in usersList {
                    if each.online {
                        onlineUsers.append(RoomUser(username: each.username, online: each.online))
                    } else {
                        offlineUsers.append(RoomUser(username: each.username, online: each.online))
                    }
                }
                
                self.onlineUsers = onlineUsers
                self.offlineUsers = offlineUsers
            }
        } else {
            self.onlineUsers = [RoomUser(username: sharedDataManager.currentUsername!, online: true)]
            self.offlineUsers = []
        }
    }
    
    func createUser(username: String, password: String) throws {
        // in case user already created with such name it will throw an error
        let user = try UserData(username: username, password: password)
        try userLoadToSelf(userData: user, password: password)
    }
    
    func userLoadToSelf(userData: UserData, password: String) throws {
        // get key from password
        self.currentUsername = userData.username
        self.user = userData
        let roomsJoinedByUser: [RoomData]? = try self.user!.getAllRoomsJoined()
        if roomsJoinedByUser != nil {
            var roomsList: [Room] = []
            for each in roomsJoinedByUser! {
                let room = Room(each)
                roomsList.append(room)
            }
            self.userJoinedRooms = roomsList
        }
        
        getOnlineOfflineUsers()
        self.storage.setUserLoginData(username: userData.username, password: password)
    }
    
    func login(username: String, password: String) throws {
        let user = try UserData(by: username)
        if Hashing.verify(hash: user.passwordHash, password: password) {
            try userLoadToSelf(userData: user, password: password)
        } else {
            throw NSError(domain: "Wrong password", code: 401)
        }
    }
    
    func logout() throws {
        self.user!.online = false
        let _ = try self.user!.update()
        self.storage.removeUserLoginData()
        emptyIt()
    }
    
    private func emptyIt() {
        self.currentUsername = nil
        self.currentRoom = nil
        self.user = nil
        self.userJoinedRooms = nil
        self.onlineUsers = nil
        self.offlineUsers = nil
//        self.shortUserAccounts = nil
    }
    
    // User must be able to be found to login
    // User must obtain rooms with messages, after log in
    // User must see users status, that are joined in the same rooms
    // User must be able to create new room
    // User must be able to view all messages that were written only by the user
}

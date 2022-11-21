//
//  User.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

// held in UD
struct UserData: Decodable, Encodable {
    var uuid: String
    var online: Bool
    var username: String
    var passwordHash: String
//    var roomsKeys: [String] // from UD joined/created by user
    
    // create user
    init(username: String, password: String) throws {
        // check if user already exist
        let res = sharedDataManager.storage.get(by: "user")
        
        if let users = res as? [UserData] {
            for each in users {
                if each.username == username {
                    throw NSError(domain: "User already exist", code: 409)
                }
            }
        }
        
        // Creating new user
        self.uuid = UUID().uuidString
        self.online = true
        self.username = username
        self.passwordHash = Hashing.hash(password)
//        self.roomsKeys = []
        
        let creationSuccess = sharedDataManager.storage.update(to: "user", data: self)
        
        if !creationSuccess {
            throw NSError(domain: "Failed to add user", code: 409)
        }
        
    }
    
    // get user by username
    // wib?
    init(by username: String) throws {
        let res = sharedDataManager.storage.get(by: "user")
        if let users = res as? [UserData] {
            for each in users {
                if each.username == username {
                    self = each
                    self.online = true
                    if !sharedDataManager.storage.update(to: "user", data: self) {
                        throw NSError(domain: "Failed to update user status", code: 409)
                    }
                    return
                }
            }
        }
        throw NSError(domain: "No user was found", code: 404)
    }
    
    // update user in UD and Storage
    func update() throws -> UserData? {
        
        if sharedDataManager.storage.update(to: "user", data: self) {
            return self
        }
        throw NSError(domain: "Failed to update user.", code: 500)
    }
    
    /// Creates the room in UD and returns its encryption key
    func createRoom(roomName: String) throws {
        let res = sharedDataManager.storage.get(by: "room")
        
        if let rooms = res as? [RoomData] {
            for each in rooms {
                if each.roomName == roomName {
                    throw NSError(domain: "Room with such name already exists", code: 409)
                }
            }
        }
        
        let room = try RoomData(roomName: roomName)
        
        let roomAdded = sharedDataManager.storage.update(to: "room", data: room)
        if roomAdded {
            sharedDataManager.updateRoomData(data: room)
        } else {
            throw NSError(domain: "Room was not added", code: 409)
        }
        
    }
    
    func getAllRoomsJoined() throws -> [RoomData]? {
        let res = sharedDataManager.storage.get(by: "room")
        
        var userRooms: [RoomData] = []
        
        if let list = res as? [RoomData] {
            for room in list {
                var isUserInTheRoom = false
                var roomToReturn: RoomData? = nil
                for id in room.usersUUIDs {
                    if id == self.uuid {
                        roomToReturn = room
                        isUserInTheRoom = true
                        break
                    }
                }
                if isUserInTheRoom {
                    userRooms.append(roomToReturn!)
                }
            }
            return userRooms
        }
        return nil
    }
    
    func joinRoom(roomName: String) throws -> Room {
        
        if let userJoinedRooms = sharedDataManager.userJoinedRooms {
            for each in userJoinedRooms {
                if each.data.roomName == roomName {
                    return each
                }
            }
        }
        
        if let list = sharedDataManager.storage.get(by: "room") as? [RoomData] {
            
            var roomToReturn: Room? = nil
            
            for room in list {
                if room.roomName == roomName {
                    // check if current uuid joined the room
                    var newUsersUUIDs = room.usersUUIDs
                    newUsersUUIDs.append(self.uuid)
                    
                    let updatedRoom: RoomData = RoomData(
                        uuid: room.uuid,
                        roomName: room.roomName,
                        usersUUIDs: newUsersUUIDs,
                        messagesUUIDs: room.messagesUUIDs
                    )
                    
                    if sharedDataManager.storage.update(to: "room", data: updatedRoom) {
                        roomToReturn = Room(updatedRoom)
                    } else {
                        throw NSError(domain: "New user is not added to the room", code: 500)
                    }
                    
                }
            }
            
            if roomToReturn == nil {
                throw NSError(domain: "Room: \(roomName) is not created", code: 409)
            }
            return roomToReturn!
            
        }
        throw NSError(domain: "Room was not joined", code: 409)
    }
        
    mutating func changeUsername(username: String) throws {
        if let users = sharedDataManager.storage.get(by: "user") as? [UserData] {
            for each in users {
                if each.username == username {
                    throw NSError(domain: "User with such username exist", code: 409)
                }
            }
        }
        
        self.username = username
        let _ = try self.update()
    }
    
    mutating func changePassword(oldPassword: String, newPassword: String) throws {
        if Hashing.verify(hash: self.passwordHash, password: oldPassword) {
            self.passwordHash = Hashing.hash(newPassword)
            let _ = try self.update()
        }
    }
    
}


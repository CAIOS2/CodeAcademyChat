//
//  User.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation
import CryptoKit

// Room
// uuid
// messages unencrypted
// users (short online) list
    // username
    // online
// symmetric key


// held in UD
struct UserData: Decodable, Encodable {
    var uuid: String
    var online: Bool
    var username: String
    var passwordHash: String
    var roomsKeys: [String] // from UD joined/created by user
//    var messagesKeys: [String] // from UD written by user
    
    // create user
    init(username: String, password: String, storage: Storage) throws {
        // check if user already exist
        let res = storage.get(by: "user")
        
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
        self.roomsKeys = []
        
        let creationSuccess = storage.add(to: "user", data: self)
        
        if !creationSuccess {
            throw NSError(domain: "Failed to add user", code: 409)
        }
        
    }
    
    // get user by username
    // wib?
    init(by username: String, from storage: Storage) throws {
        let res = storage.get(by: "user")
        
        if let users = res as? [UserData] {
            for each in users {
                if each.username == username {
                    self = each
                    return
                }
            }
        }
        throw NSError(domain: "No user was found", code: 404)
    }
    
    // update user in UD and Storage
    func update(in storage: Storage) throws -> UserData? {
        
        if storage.update(key: "user", data: self) {
            return self
        }
        return nil
    }
    
    /// Creates the room in UD and returns its encryption key
    /// 0 - room, 1 - symmetric key
    func createRoom(roomName: String, in storage: Storage, password: String) throws -> (RoomData, SymmetricKey) {
        let res = storage.get(by: "room")
        
        if let rooms = res as? [RoomData] {
            for each in rooms {
                if each.roomName == roomName {
                    throw NSError(domain: "Room with such name already exists", code: 409)
                }
            }
        }
        
        let room = RoomData(roomName: roomName, userUUID: self.uuid, password: password)
        let roomUserKey: SymmetricKey = try room.getUserEncryptionKey(userUUID: self.uuid, password: password)
        
        let roomAdded = storage.add(to: "room", data: room)
        if roomAdded {
            return (room, roomUserKey)
        } else {
            throw NSError(domain: "Room was not added", code: 409)
        }
    }
    
    func getAllRoomsJoined(from storage: Storage, password: String) throws -> [(RoomData, SymmetricKey)]? {
        let res = storage.get(by: "room")
        
        var userRooms: [(RoomData, SymmetricKey)] = []
        
        if let list = res as? [RoomData] {
            for each in list {
                var userIsInTheRoom = false
                var room: RoomData? = nil
                innerloop: for every in each.usersUUIDs {
                    if every == self.uuid {
                        room = each
                        userIsInTheRoom = true
                        break innerloop
                    }
                }
                if userIsInTheRoom {
                    userRooms.append((room!, try each.getUserEncryptionKey(userUUID: self.uuid, password: password)))
                }
            }
            return userRooms
        }
        return nil
    }
    
    func joinRoom(roomName: String, in storage: Storage, password: String) throws -> (RoomData, SymmetricKey) {
        
        let res = storage.get(by: "room")
        if let list = res as? [RoomData] {
            for each in list {
                if each.roomName == roomName {
                    // create key of user
                    let passwordSymKey = Encryptor.prepareKey(key: Encryptor.createKey(password: password))
                    let newEncryptionKey = Encryptor.createKey()
                    let newEncryptionKeyEncrypted = Encryptor.encrypt(symKey: passwordSymKey, data: Encryptor.createKey())
                    
                    var newUsersUUIDs = each.usersUUIDs
                    newUsersUUIDs.append(self.uuid)
                    
                    var newUserEncryptionKeys = each.userEncryptionKeys
                    newUserEncryptionKeys.append("\(self.uuid):\(newEncryptionKeyEncrypted)")
                    
                    let updateRoom: RoomData = RoomData(
                        uuid: each.uuid,
                        roomName: each.roomName,
                        usersUUIDs: newUsersUUIDs,
                        messagesUUIDs: each.messagesUUIDs,
                        userEncryptionKeys: newUserEncryptionKeys
                    )
                    
                    
                    let updated = storage.update(key: "room", data: updateRoom)
                    if updated {
                        return (updateRoom, Encryptor.prepareKey(key: newEncryptionKey))
                    }
                        
                     break
                    }
                }
            }
        throw NSError(domain: "Room was not joined", code: 409)
    }
        
    
}


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
        // Checking if data is duplicating
        var res = storage.get(by: "user")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        let users = res.data as! [UserData]
        for user in users {
            if user.username == username {
                throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
            }
        }
        // Proving data is not duplicating
        self.uuid = UUID().uuidString
        self.online = true
        self.username = username
        self.passwordHash = Hashing.hash(password)
        self.roomsKeys = []
//        self.messagesKeys = []
        
        res = storage.add(to: "user", data: self)
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        
    }
    
    // get user by username
    // wib?
    init(by username: String, from storage: Storage) throws {
        let res = storage.get(by: "user")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        let users = res.data as! [UserData]
        for user in users {
            if user.username == username {
                self.uuid = user.uuid
                self.online = user.online
                self.username = user.username
                self.passwordHash = user.passwordHash
                self.roomsKeys = user.roomsKeys
//                self.messagesKeys = user.messagesKeys
                return
            }
        }
        
        // debug
        let error = ErrorCodes(ErrorCode.NotFound, message: "User is not found")
        throw NSError(domain: error.getString(), code: error.getCode())
    }
    
    // update user in UD and Storage
    func update(in storage: Storage) throws -> UserData? {
        var res = storage.get(by: "user")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        let users = res.data as! [UserData]
        var newUserList: [UserData] = []
        for each in users {
            if each.username == self.username {
                newUserList.append(self)
            } else {
                newUserList.append(each)
            }
        }
        res = storage.set(key: "user", data: newUserList)
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        } else {
            return self
        }
    }
    
    /// Creates the room in UD and returns its encryption key
    /// 0 - room, 1 - symmetric key
    func createRoom(roomName: String, in storage: Storage, password: String) throws -> (RoomData, SymmetricKey) {
        var res = storage.get(by: "room")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        let list = res.data as! [RoomData]
        for each in list {
            if each.roomName == roomName {
                throw NSError(domain: "Room with specified name: \(roomName), already exist", code: 409)
            }
        }
        
        let room = RoomData(roomName: roomName, userUUID: self.uuid, password: password)
        let roomUserKey: SymmetricKey = try room.getUserEncryptionKey(userUUID: self.uuid, password: password)
        
        res = storage.add(to: "room", data: room)
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        } else {
            return (room, roomUserKey)
        }
    }
    
    func getAllRooms(from storage: Storage, password: String) throws -> [(RoomData, SymmetricKey)] {
        let res = storage.get(by: "room")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        
        var userRooms: [(RoomData, SymmetricKey)] = []
        let list = res.data as! [RoomData]
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
    
    func joinRoom(roomName: String, in storage: Storage, password: String) throws -> (RoomData, SymmetricKey) {
        let res = try getAllRooms(from: storage, password: password)
        for each in res {
            if each.0.roomName == roomName {
                let passwordSymKey = Encryptor.prepareKey(key: Encryptor.createKey(password: password))
                let newEncryptionKey = Encryptor.encrypt(symKey: passwordSymKey, data: Encryptor.createKey())
                
                var newUsersUUIDs = each.0.usersUUIDs
                newUsersUUIDs.append(self.uuid)
                
                var newUserEncryptionKeys = each.0.userEncryptionKeys
                newUserEncryptionKeys.append("\(self.uuid):\(newEncryptionKey)")
                
                var res = storage.get(by: "room")
                if res.error != nil {
                    throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
                }
                let updatedRoom: RoomData = RoomData(
                    uuid: each.0.uuid,
                    roomName: each.0.roomName,
                    usersUUIDs: newUsersUUIDs,
                    messagesUUIDs: each.0.messagesUUIDs,
                    userEncryptionKeys: newUserEncryptionKeys
                )
                
                var newList: [RoomData] = []
                for every in res.data as! [RoomData] {
                    if every.roomName == each.0.roomName {
                        newList.append(updatedRoom)
                    } else {
                        newList.append(every)
                    }
                }
                res = storage.set(key: "room", data: newList)
                if res.error != nil {
                    throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
                }
                return (updatedRoom, each.1)
            }
        }
        throw NSError(domain: "Room with provided name was not found", code: 404)
    }
}


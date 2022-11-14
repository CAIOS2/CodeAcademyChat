//
//  Room.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation
import CryptoKit


struct RoomUser {
    var username: String
    var online: Bool
}

struct RoomMessage {
    var uuid: String
    var roomUser: RoomUser
    var message: String //unencrypted
    var date: Date
}

struct RoomData: Decodable, Encodable {
    let uuid: String
    let roomName: String
    var usersUUIDs: [String]
//    var onlineUsersKeys: [String]
//    var offlineUsersKeys: [String]
    var messagesUUIDs: [String]
    // UUID:EncryptedKey
    // every key is encrypted with user password
    var userEncryptionKeys: [String]
    
//    var currentEncryptionKey: String? = nil
    
    init(uuid: String, roomName: String, usersUUIDs: [String], messagesUUIDs: [String], userEncryptionKeys: [String]) {
        self.uuid = uuid
        self.roomName = roomName
        self.usersUUIDs = usersUUIDs
        self.messagesUUIDs = messagesUUIDs
        self.userEncryptionKeys = userEncryptionKeys
    }
    
    init(roomName: String, userUUID: String, password: String) {
        self.uuid = UUID().uuidString
        self.roomName = roomName
        
        self.usersUUIDs = [userUUID]
        self.messagesUUIDs = []
        
        let key = Encryptor.createKey(password: password)
        self.userEncryptionKeys = ["\(self.usersUUIDs[0]):\(key)"]
        
        
        
    }
    
    func getUserEncryptionKey(userUUID: String, password: String) throws -> SymmetricKey {
        // userEncryptionKeys are passed in following format:
        // userUUID:Key
        for each in self.userEncryptionKeys {
            let pair = each.split(separator: ":")
            if String(pair[0]) == userUUID {
                let passKey: SymmetricKey = Encryptor.prepareKey(key: Encryptor.createKey(password: password))
                let encKey: String = Encryptor.decrypt(symKey: passKey, data: String(pair[1]))
                return Encryptor.prepareKey(key: encKey)
            }
        }
        let error = ErrorCodes(ErrorCode.Unauthorized, message: "Requested key is not found by user UUID: \(userUUID)")
        throw NSError(domain: error.getString(), code: error.getCode())
    }
    
    // Only load if given key is mat
    func load(from storage: Storage, symKey: SymmetricKey) throws -> ([ShortUserAccount], [RoomMessage]) {
        // get messages by uuid using messagesUUIDs
        // show them using key
        var res = storage.get(by: "room")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        
        
        let rooms: [RoomData] = res.data as! [RoomData]
        
        var messagesUUIDs: [String] = []
        
        for room in rooms {
            if room.uuid == self.uuid {
                for messageUUID in room.messagesUUIDs {
                    messagesUUIDs.append(messageUUID)
                }
            }
        }
        
        var messagesOpen: [MessageOpenData] = []
        if !messagesUUIDs.isEmpty {
            // open messages
            
            res = storage.get(by: "message")
            if res.error != nil {
                throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
            }
            let messages: [MessageData] = res.data as! [MessageData]
            for message in messages {
                inner: for uuid in messagesUUIDs {
                    if uuid == message.uuid {
                        
                        messagesOpen.append(message.show(using: symKey))
                        break inner
                    }
                }
            }
        }
        
        
        
        // users list participating in the room
        res = storage.get(by: "user")
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        
        let users = res.data as! [UserData]

        var roomUsers: [ShortUserAccount] = []
        for user in users {
            inner: for uuid in self.usersUUIDs {
                if user.uuid == uuid {
                    roomUsers.append(
                        ShortUserAccount(uuid: user.uuid, username: user.username, online: user.online, passwordHash: user.passwordHash)
                    )
                    break inner
                }
            }
            
        }
        
        //
        var roomMessages: [RoomMessage] = []
        // prepare final messages
        for message in messagesOpen {
            inner: for user in roomUsers {
                if message.username == user.username {
                    let room: RoomMessage = RoomMessage(
                        uuid: message.uuid,
                        roomUser: RoomUser(username: message.username, online: user.online),
                        message: message.message,
                        date: message.date
                    )
                    roomMessages.append(room)
                    break inner
                }
            }
        }
        return (roomUsers, roomMessages)
        
    }
    
    func addMessage(to storage: Storage, message: String, username: String, symKey: SymmetricKey) throws -> ([ShortUserAccount], [RoomMessage]) {
        let message = MessageData(message: message, username: username, symKey: symKey)
        let res = storage.add(to: "message", data: message)
        if res.error != nil {
            throw NSError(domain: (res.error as! ErrorCodes).getString(), code: (res.error as! ErrorCodes).getCode())
        }
        return try self.load(from: storage, symKey: symKey)
    }
}

// Room has a key, that is given to each user that is connected to it (knows about it)
class Room {
    var data: RoomData
    var users: [RoomUser]? = nil
    var messages: [RoomMessage]? = nil
    
    // uuid of user and encrypted key
    // key is the same for every user, encrypted with every user's password
    
    // obtain
    init(roomData: RoomData) {
        self.data = roomData
    }
    
    
    
    func load(in storage: Storage, decrypting symKey: SymmetricKey) throws {
        let res = try self.data.load(from: storage, symKey: symKey)
        self.messages = res.1
        
        var roomUsers: [RoomUser] = []
        for each in res.0 {
            roomUsers.append(RoomUser(username: each.username, online: each.online))
        }
        self.users = roomUsers
    }
    
    func addMessage(in storage: Storage, message: String, username: String, symKey: SymmetricKey) throws {
        let res = try self.data.addMessage(to: storage, message: message, username: username, symKey: symKey)
        self.messages = res.1
        
        var roomUsers: [RoomUser] = []
        for each in res.0 {
            roomUsers.append(RoomUser(username: each.username, online: each.online))
        }
        self.users = roomUsers
    }
}

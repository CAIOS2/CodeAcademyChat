//
//  Room.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

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
    var messagesUUIDs: [String]
    // userUUID:EncryptedKey
    // every key is encrypted with user password
    var userEncryptionKeys: [String]
    
    init(uuid: String, roomName: String, usersUUIDs: [String], messagesUUIDs: [String], userEncryptionKeys: [String]) {
        self.uuid = uuid
        self.roomName = roomName
        self.usersUUIDs = usersUUIDs
        self.messagesUUIDs = messagesUUIDs
        self.userEncryptionKeys = userEncryptionKeys
    }
    
    init(roomName: String) throws {
        self.uuid = UUID().uuidString
        self.roomName = roomName
        
        self.usersUUIDs = [sharedDataManager.user!.uuid]
        self.messagesUUIDs = []
        
//        let key = try aes.createKey(
//            password: sharedDataManager.currentPassword!,
//            username: sharedDataManager.currentUsername!
//        ) as String
        let key = try aes.createKey() as String
        let encryptedKey = try aes.encrypt(data: key, key: sharedDataManager.currentPasswordKey!)
        
        self.userEncryptionKeys = ["\(self.usersUUIDs[0]):\(encryptedKey)"]
    }
    
    func getUserEncryptionKey(userUUID: String) throws -> [UInt8] {
        // userEncryptionKeys are passed in following format:
        // userUUID:Key
        for each in self.userEncryptionKeys {
            let pair = each.split(separator: ":")
            if String(pair[0]) == userUUID {
                // encrypt new key with key made from password
                let key: String = try aes.decrypt(data: String(pair[1]), key: sharedDataManager.currentPasswordKey!)
                return key.bytes
            }
        }
        let error = ErrorCodes(ErrorCode.Unauthorized, message: "Requested key is not found by user UUID: \(userUUID)")
        throw NSError(domain: error.getString(), code: error.getCode())
    }
    
    
    func load(from storage: Storage, key: [UInt8]) throws -> ([ShortUserAccount], [RoomMessage]?) {
        // get messages by uuid using messagesUUIDs
        // show them using key
        
        // get room from storage
        let resR = storage.get(by: "room")
        if let rooms = resR as? [RoomData] {
            // collecting messagesUUID of room
            var messagesUUIDs: [String] = []
            
            for room in rooms {
                if room.uuid == self.uuid {
                    for messageUUID in room.messagesUUIDs {
                        messagesUUIDs.append(messageUUID)
                    }
                }
            }
            
            // collect user list that is participating in the room
            let resU = storage.get(by: "user")
            if let users = resU as? [UserData] {
                
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
                // collect messages in decrypted format
                var messagesOpen: [MessageOpenData] = []
                if !messagesUUIDs.isEmpty {
                    // open messages
                    let resM = storage.get(by: "message")
                    
                    if let messages = resM as? [MessageData] {
                        for message in messages {
                        inner: for uuid in messagesUUIDs {
                            if uuid == message.uuid {
                                
                                messagesOpen.append(try message.show(using: key))
                                break inner
                            }
                        }
                        }
                        
                        var roomMessages: [RoomMessage] = []
                        // prepare final messages, that have user online status
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
                    } else {
                        return (roomUsers, nil)
                    }
                } else {
                    throw NSError(domain: "Cannot collect messages, when they are", code: 500)
                }
            } else {
                throw NSError(domain: "No users in the room were found", code: 404)
            }
        } else {
            throw NSError(domain: "Room was not found", code: 404)
        }
            
    }
    
    func addMessage(to storage: Storage, message: String, username: String, key: [UInt8]) throws -> ([ShortUserAccount], [RoomMessage]?) {
        let message = try MessageData(message: message, username: username, key: key)
        let isMessageAdded = storage.add(to: "message", data: message)
        if !isMessageAdded {
            throw NSError(domain: "Message was not sent", code: 409)
        }
        
        return try self.load(from: storage, key: key)
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
    init(_ roomData: RoomData) {
        self.data = roomData
    }
    
    func load(in storage: Storage, decrypting key: [UInt8]) throws {
        let room = try self.data.load(from: storage, key: key)
        loadToSelf(messages: room.1, users: room.0)
        
    }
    
    func addMessage(in storage: Storage, message: String, username: String, key: [UInt8]) throws {
        let room = try self.data.addMessage(to: storage, message: message, username: username, key: key)
        loadToSelf(messages: room.1, users: room.0)
    }
    
    
    
    private func loadToSelf(messages: [RoomMessage]?, users: [ShortUserAccount]) {
        self.messages = messages
        
        var roomUsers: [RoomUser] = []
        for each in users {
            roomUsers.append(RoomUser(username: each.username, online: each.online))
        }
        self.users = roomUsers
    }
}

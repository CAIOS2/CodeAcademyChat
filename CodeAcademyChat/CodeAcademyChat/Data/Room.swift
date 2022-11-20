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
    
    func prepareDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY.MM.dd HH:mm"
        return dateFormatter.string(from: self.date)
    }
    
    func prepareUsername() -> String {
        var state = "🟢"
        if !self.roomUser.online {
            state = "🔴"
        }
        return "\(self.roomUser.username)\(state)"
    }
    
    func isMessageSentByUser() -> Bool {
        if self.roomUser.username != sharedDataManager.currentUsername {
            return false
        }
        return true
    }
}

struct RoomData: Decodable, Encodable {
    let uuid: String
    let roomName: String
    var usersUUIDs: [String]
    var messagesUUIDs: [String]
    
    init(uuid: String, roomName: String, usersUUIDs: [String], messagesUUIDs: [String]) {
        self.uuid = uuid
        self.roomName = roomName
        self.usersUUIDs = usersUUIDs
        self.messagesUUIDs = messagesUUIDs
    }
    
    init(roomName: String) throws {
        self.uuid = UUID().uuidString
        self.roomName = roomName
        
        self.usersUUIDs = [sharedDataManager.user!.uuid]
        self.messagesUUIDs = []
    }
    
    
    func load(using key: [UInt8]) throws -> (roomUsers: [RoomUser], roomMessages: [RoomMessage]?) {
        // get messages by uuid using messagesUUIDs
        // show them using key
        
        // get room from storage
        let resR = sharedDataManager.storage.get(by: "room")
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
            let resU = sharedDataManager.storage.get(by: "user")
            if let users = resU as? [UserData] {
                
                var roomUsers: [RoomUser] = []
                for user in users {
                inner: for uuid in self.usersUUIDs {
                    if user.uuid == uuid {
                        roomUsers.append(
                            RoomUser(username: user.username, online: user.online)
                        )
                        break inner
                    }
                }
                    
                }
                // collect messages in decrypted format
                var messagesOpen: [MessageOpenData] = []
                if !messagesUUIDs.isEmpty {
                    // open messages
                    let resM = sharedDataManager.storage.get(by: "message")
                    
                    if let messages = resM as? [MessageData] {
                        for message in messages {
                            for uuid in messagesUUIDs {
                                if uuid == message.uuid {
                                    messagesOpen.append(try message.show(using: key))
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
                    return (roomUsers, nil)
                }
            } else {
                throw NSError(domain: "No users in the room were found", code: 404)
            }
        } else {
            throw NSError(domain: "Room was not found", code: 404)
        }
            
    }
    
    /// Adds encrypted message to UserDefaults
    /// Call from Room
    mutating func addMessage(message: String, username: String, key: [UInt8]) throws -> (roomUsers: [RoomUser], roomMessages: [RoomMessage]?) {
        let message = try MessageData(message: message, username: username, key: key)
        let isMessageAdded = sharedDataManager.storage.update(to: "message", data: message)
        if !isMessageAdded {
            throw NSError(domain: "Message was not sent", code: 409)
        }
        var newMessagesUUIDs: [String] = self.messagesUUIDs
        newMessagesUUIDs.append(message.uuid)
        try updateRoomMessagesUUIDs(list: newMessagesUUIDs)
        
        
        return try self.load(using: key)
    }
    
    mutating func updateRoomMessagesUUIDs(list: [String]) throws {
        self.messagesUUIDs = list
        if !sharedDataManager.storage.update(to: "room", data: self) {
            throw NSError(domain: "UserDefaults didn't receive message update", code: 500)
        }
    }
}

// Room has a key, that is given to each user that is connected to it (knows about it)
class Room {
    var data: RoomData
    var users: [RoomUser]? = nil
    var messages: [RoomMessage]? = nil
    var key: [UInt8]
    
    // uuid of user and encrypted key
    // key is the same for every user, encrypted with every user's password
    
    // obtain
    init(_ roomData: RoomData) {
        self.data = roomData
        do {
            self.key = try rabbit.createKey(password: roomData.roomName, username: roomData.roomName)
            try load()
        } catch let e as NSError {
            fatalError("Failed to create key of room id: \(data.roomName). Error: \(e.self)")
        }
    }
    
    func load() throws {
        let room = try self.data.load(using: self.key)
        self.messages = room.roomMessages
        self.users = room.roomUsers
    }
    
    func addMessage(message: String, username: String) throws {
        let room = try self.data.addMessage(message: message, username: username, key: self.key)
        self.messages = room.roomMessages
        self.users = room.roomUsers
    }
}

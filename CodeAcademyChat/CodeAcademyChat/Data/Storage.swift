//
//  DefaultStorage.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

enum DataType {
    case User, Room, Message
}

class Storage {
    // UD - UserDefaults
    static let defaults = UserDefaults.standard
    // Storage
    var users: [UserData]?
    var rooms: [RoomData]?
    var messages: [MessageData]?
    
    func getUserLoginData() -> (String, String)? {
        if let username = Storage.defaults.string(forKey: "username") {
            if let password = Storage.defaults.string(forKey: "password") {
                return (username, password)
            }
        }
        return nil
    }
    
    func setUserLoginData(username: String, password: String) {
        Storage.defaults.set(username, forKey: "username")
        Storage.defaults.set(password, forKey: "password")
    }
    
    func removeUserLoginData() {
        Storage.defaults.removeObject(forKey: "username")
        Storage.defaults.removeObject(forKey: "password")
    }
    
    
    
    
    init() {
        // check if required lists are already created in UD
        updateListsFromUD()
    }
    
    
    /// Get desired list from Storage
    /// Each time auto-updates existing variables in
    /// Storage class from UD
    func get(by key: String) -> [Any]? {
        updateListsFromUD()
        
        switch key {
        case "user":
            return self.users
        case "room":
            return self.rooms
        case "message":
            return self.messages
        default:
            return nil
        }
    }
    
    /// Adds new data to list of key in Storage and UD
    func add(to key: String, data: Any) -> Bool {
        switch key {
        case "user":
            addUser(user: data as! UserData)
            return true
        case "room":
            addRoom(room: data as! RoomData)
            return true
        case "message":
            addMessage(message: data as! MessageData)
            return true
        default:
            return false
        }
    }
    
    func set(key: String, data: [Any]) -> Bool {
        switch key {
        case "user":
            setUsers(list: data as! [UserData])
            return true
        case "room":
            setRooms(list: data as! [RoomData])
            return true
        case "message":
            setMessages(list: data as! [MessageData])
            return true
        default:
            return false
        }
    }
    
    func update(key: String, data: Any) -> Bool {
        switch key {
        case "user":
            updateUser(user: data as! UserData)
            return true
        case "room":
            updateRoom(room: data as! RoomData)
            return true
        case "message":
            updateMessage(message: data as! MessageData)
            return true
        default:
            return false
        }
    }
    
    // obtains lists from UD
    private func getListUD(key: String) -> [Any]? {
        switch key {
        case "user":
            if let list = getUsersUD() {
                return list
            }
            return nil
        case "room":
            if let list = getRoomsUD() {
                return list
            }
            return nil
        
        case "message":
            if let list = getMessagesUD() {
                return list
            }
            return nil
        default: return nil
        }
    }
    
    
    
    private func updateListsFromUD() {
        let _ = getUsersUD()
        let _ = getRoomsUD()
        let _ = getMessagesUD()
    }

    
    private func getUsersUD() -> [UserData]? {
        if let jUsers = Storage.defaults.string(forKey: "user") {
            if jUsers == "" {
                return nil
            }
            let users: [UserData]? = instantiate(jsonString: jUsers)
            self.users = users!
            return self.users
        }
        return nil
    }

    private func getRoomsUD() -> [RoomData]? {
        if let jRooms = Storage.defaults.string(forKey: "room") {
            if jRooms == "" {
                return nil
            }
            let rooms: [RoomData]? = instantiate(jsonString: jRooms)
            self.rooms = rooms!
            return self.rooms
        }
        return nil
    }

    private func getMessagesUD() -> [MessageData]? {
        if let jMessages = Storage.defaults.string(forKey: "messages") {
            if jMessages == "" {
                return nil
            }
            let messages: [MessageData]? = instantiate(jsonString: jMessages)
            self.messages = messages!
            return self.messages
        }
        return nil
    }
    
    private func setUsers(list: [UserData]) {
        if !list.isEmpty {
            Storage.defaults.set(list.toJSONString(), forKey: "user")
            self.users = list
        }
    }
    
    private func addUser(user: UserData) {
        if var newList = self.users {
            newList.append(user)
            setUsers(list: newList)
        }
        setUsers(list: [user])
    }
    
    private func setRooms(list: [RoomData]) {
        if !list.isEmpty {
            Storage.defaults.set(list.toJSONString(), forKey: "room")
            self.rooms = list
        }
    }
    
    private func addRoom(room: RoomData) {
        if var newList = self.rooms {
            newList.append(room)
            setRooms(list: newList)
        }
        setRooms(list: [room])
    }
    
    
    
    private func setMessages(list: [MessageData]) {
        if !list.isEmpty {
            Storage.defaults.set(list.toJSONString(), forKey: "message")
            self.messages = list
        }
    }
    
    private func addMessage(message: MessageData) {
        if var newList = self.messages {
            newList.append(message)
            setMessages(list: newList)
        }
        setMessages(list: [message])
    }
    
    private func updateUser(user: UserData) {
        let res = getUsersUD()
        var newList: [UserData] = []
        if let users = res {
            for each in users {
                if each.username == user.username {
                    newList.append(user)
                } else {
                    newList.append(each)
                }
            }
        }
        setUsers(list: newList)
    }
    
    private func updateRoom(room: RoomData) {
        let res = getRoomsUD()
        var newList: [RoomData] = []
        if let rooms = res {
            for each in rooms {
                if each.uuid == room.uuid {
                    newList.append(room)
                } else {
                    newList.append(each)
                }
            }
        }
        setRooms(list: newList)
    }
    
    private func updateMessage(message: MessageData) {
        let res = getMessagesUD()
        var newList: [MessageData] = []
        if let messages = res {
            for each in messages {
                if each.uuid == message.uuid {
                    newList.append(message)
                } else {
                    newList.append(each)
                }
            }
        }
        setMessages(list: newList)
    }
    
}

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
    
    init() {
        // check if required lists are already created in UD
        updateListsFromUD()
    }
    
    // MARK: User login data
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
    
    
    // MARK: Public functions - get, add, set, update
    
    /// Get desired list from Storage
    func get(by key: String) -> [Any]? {
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
    
//    /// Adds new data to list of key in Storage and UD
//    func add(to key: String, data: Any) -> Bool {
//        switch key {
//        case "user":
//            addUser(user: data as! UserData)
//            return true
//        case "room":
//            addRoom(room: data as! RoomData)
//            return true
//        case "message":
//            addMessage(message: data as! MessageData)
//            return true
//        default:
//            return false
//        }
//    }
    
//    /// Sets data provided to the list of key
//    func set(to key: String, data: [Any]) -> Bool {
//        switch key {
//        case "user":
//            setUsers(list: data as! [UserData])
//            return true
//        case "room":
//            setRooms(list: data as! [RoomData])
//            return true
//        case "message":
//            setMessages(list: data as! [MessageData])
//            return true
//        default:
//            return false
//        }
//    }
    
    /// Updates existing data by finding it in list of key
    /// Can add a new element, find existing or add new
    func update(to key: String, data: Any) -> Bool {
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
    
    // MARK: - Getting desired list from UserDefaults
    
    // obtains lists from UserDefaults
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
        self.users = getUsersUD()
        self.rooms = getRoomsUD()
        self.messages = getMessagesUD()
    }

    private func getUsersUD() -> [UserData]? {
        if let jUsers = Storage.defaults.string(forKey: "user") {
            if jUsers == "" {
                return nil
            }
            let users: [UserData]? = instantiate(jsonString: jUsers)
            return users!
        }
        return nil
    }

    private func getRoomsUD() -> [RoomData]? {
        if let jRooms = Storage.defaults.string(forKey: "room") {
            if jRooms == "" {
                return nil
            }
            let rooms: [RoomData]? = instantiate(jsonString: jRooms)
            return rooms!
        }
        return nil
    }

    private func getMessagesUD() -> [MessageData]? {
        if let jMessages = Storage.defaults.string(forKey: "messages") {
            if jMessages == "" {
                return nil
            }
            let messages: [MessageData]? = instantiate(jsonString: jMessages)
            return messages!
        }
        return nil
    }
    
    // MARK: - Setting to list
    
    private func setUsers(list: [UserData]) {
        self.users = list
        Storage.defaults.set(list.toJSONString(), forKey: "user")
    }
    
    private func setRooms(list: [RoomData]) {
        self.rooms = list
        Storage.defaults.set(list.toJSONString(), forKey: "room")
    }
    
    private func setMessages(list: [MessageData]) {
        self.messages = list
        Storage.defaults.set(list.toJSONString(), forKey: "message")
    }
    
    // MARK: Making new list by adding data and setting
    
    private func addUser(user: UserData) {
        if var newList = self.users {
            newList.append(user)
            setUsers(list: newList)
        } else {
            setUsers(list: [user])
        }
        
    }
    
    private func addRoom(room: RoomData) {
        if var newList = self.rooms {
            newList.append(room)
            setRooms(list: newList)
        } else {
            setRooms(list: [room])
        }
        
    }
    
    private func addMessage(message: MessageData) {
        if var newList = self.messages {
            newList.append(message)
            setMessages(list: newList)
        } else {
            setMessages(list: [message])
        }
        
    }
    
    // MARK: Making new list by replacing data and setting
    
    private func updateUser(user: UserData) {
        var newList: [UserData] = []
        if let prevList = self.users {
            var isUserAdded = false
            for each in prevList {
                if each.uuid == user.uuid {
                    newList.append(user)
                    isUserAdded = true
                } else {
                    newList.append(each)
                }
            }
            if !isUserAdded {
                newList.append(user)
            }
            setUsers(list: newList)
        } else {
            setUsers(list: [user])
        }
    }
    
    private func updateRoom(room: RoomData) {
        var newList: [RoomData] = []
        if let prevList = self.rooms {
            var isRoomAdded = false
            for each in prevList {
                if each.uuid == room.uuid {
                    newList.append(room)
                    isRoomAdded = true
                } else {
                    newList.append(each)
                }
            }
            if !isRoomAdded {
                newList.append(room)
            }
            setRooms(list: newList)
        } else {
            setRooms(list: [room])
        }
    }
    
    private func updateMessage(message: MessageData) {
        var newList: [MessageData] = []
        if let prevList = self.messages {
            var isMessageAdded = false
            for each in prevList {
                if each.uuid == message.uuid {
                    newList.append(message)
                    isMessageAdded = true
                } else {
                    newList.append(each)
                }
            }
            if !isMessageAdded {
                newList.append(message)
            }
            setMessages(list: newList)
        } else {
            setMessages(list: [message])
        }
    }
    
}

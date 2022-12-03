//
//  DefaultStorage.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

let defaults = UserDefaults.standard

enum DataType {
    case User, Room, Message
}

class Storage {
    var users: [UserData]?
    var rooms: [RoomData]?
    var messages: [MessageData]?
    
    init() {
        // check if required lists are already created in UD
        updateListsFromUD()
    }
    
    // MARK: User login data
    func getUserLoginData() -> (String, String)? {
        if let username = defaults.string(forKey: "username") {
            if let password = defaults.string(forKey: "password") {
                return (username, password)
            }
        }
        return nil
    }
    
    func setUserLoginData(username: String, password: String) {
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
    }
    
    func removeUserLoginData() {
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
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
        if let jUsers = defaults.string(forKey: "user") {
            if jUsers == "" {
                return nil
            }
            let users: [UserData]? = instantiate(jsonString: jUsers)
            return users!
        }
        return nil
    }

    private func getRoomsUD() -> [RoomData]? {
        if let jRooms = defaults.string(forKey: "room") {
            if jRooms == "" {
                return nil
            }
            let rooms: [RoomData]? = instantiate(jsonString: jRooms)
            return rooms!
        }
        return nil
    }

    private func getMessagesUD() -> [MessageData]? {
        if let jMessages = defaults.string(forKey: "messages") {
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
        defaults.set(list.toJSONString(), forKey: "user")
    }
    
    private func setRooms(list: [RoomData]) {
        self.rooms = list
        defaults.set(list.toJSONString(), forKey: "room")
    }
    
    private func setMessages(list: [MessageData]) {
        self.messages = list
        defaults.set(list.toJSONString(), forKey: "message")
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
        let oldJList = defaults.string(forKey: "message")
        if oldJList == nil {
            setMessages(list: [message])
            return
        }
        let oldList = instantiate(jsonString: oldJList!) as [MessageData]?
        
        if let list = oldList {
            var isMessageAdded = false
            for each in list {
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

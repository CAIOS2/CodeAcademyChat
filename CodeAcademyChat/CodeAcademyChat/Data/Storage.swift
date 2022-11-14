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
        // create required list in UD
        var keys = ["user", "room", "message"]
        for key in keys {
            var res = get(by: key)
            if res.error != nil {
                precondition(false, (res.error as! ErrorCodes).getString())
            }
            switch key {
                case "user":
                    if let data = res.data as? [UserData] {
                        self.users = data
                    } else {
                        let error = ErrorCodes(ErrorCode.InternalServerError,
                                               message: "User data list from UD doesn't match required type")
                        precondition(false, error.getString())
                    }
                case "room":
                    if let data = res.data as? [RoomData] {
                        self.rooms = data
                    } else {
                        let error = ErrorCodes(ErrorCode.InternalServerError,
                                               message: "Room data list from UD doesn't match required type")
                        precondition(false, error.getString())
                    }
                case "message":
                    if let data = res.data as? [MessageData] {
                        self.messages = data
                    } else {
                        let error = ErrorCodes(ErrorCode.InternalServerError,
                                               message: "Message data list from UD doesn't match required type")
                        precondition(false, error.getString())
                    }
                default:
                    let error = ErrorCodes(ErrorCode.NotImplemented,
                                           message: "UD for specified key is not implemented. Key: \(key)")
                    precondition(false, error.getString())
            }
        }
    }
    
    /// Get required list and creates empty if not found in UD
    /// - try to get from Storage by key
    ///     -> key not found -> NotImplemented
    /// - check if list is empty
    ///     - not empty -> return data
    ///     - empty
    ///         - is data in UD
    ///             - update list in Storage
    ///             - return list in correct type
    /// ## Returns
    /// Typisation'ed list as data or error(InternalServerError / NotImplemented)
    /// ## Other notes
    /// - Checks during UD search include NotImplemented in case key is wrong
    /// - For undefined behaviour in case,
    /// when list obtained from UD is nil -> InternalServerError
    func get(by key: String) -> Result {
        // get Storage list format
        let res = getList(key: key)
        
        if res.error != nil {
            // NotImplemented
            return res
        } else {
            if !isListEmpty(key: key, list: res.data) {
                return res
            } else {
                // get Storage list format
                return getReloadedData(key: key)
            }
        }
    }
    
    /// Adds new data to list of key in Storage and UD
    func add(to key: String, data: Any) -> Result {
        let res = get(by: key)
        if res.error != nil {
            return res
        }
        
        switch key {
            case "user":
            if var l = res.data as? [UserData] {
                l.append(data as! UserData)
                self.users = l
                let res = update(key: key, jData: self.users.toJSONString())
                return res
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed. Data is not added."))
            }
        case "room":
            if var l = res.data as? [RoomData] {
                l.append(data as! RoomData)
                self.rooms = l
                let res = update(key: key, jData: self.rooms.toJSONString())
                return res
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed. Data is not added."))
            }
        case "message":
            if var l = res.data as? [MessageData] {
                l.append(data as! MessageData)
                self.messages = l
                let res = update(key: key, jData: self.messages.toJSONString())
                return res
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed. Data is not added."))
            }
        default:
            return Result(error: ErrorCodes(ErrorCode.NotImplemented,
                                            message: "No specified key found in UD. Key: \(key)"))
        }
    }
    
    func set(key: String, data: [Any]) -> Result {
        let res = get(by: key)
        if res.error != nil {
            return res
        } else {
            switch key {
                case "user":
                if var _ = res.data as? [UserData] {
                    if let u = data as? [UserData] {
                        self.users = u
                        let res = update(key: key, jData: u.toJSONString())
                        return res
                    }
                }
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Can't parse type. Data is not setted."))
            case "room":
                if var _ = res.data as? [RoomData] {
                    if let r = data as? [RoomData] {
                        self.rooms = r
                        let res = update(key: key, jData: r.toJSONString())
                        return res
                    }
                }
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Can't parse type. Data is not setted."))
            case "message":
                if var _ = res.data as? [MessageData] {
                    if let m = data as? [MessageData] {
                        self.messages = m
                        let res = update(key: key, jData: m.toJSONString())
                        return res
                    }
                }
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Can't parse type. Data is not setted."))
            default:
                return Result(error: ErrorCodes(ErrorCode.NotImplemented,
                                                message: "No specified key found in UD. Key: \(key)"))
            }
        }
        
        
    }
    
//    /// Delete all (Debug)
//    func removeDebug(from key: String) {
//        Storage.defaults.removeObject(forKey: key)
//    }
    
    /// Updates desired UD and Storage
    ///
    /// Caution: use at your own risk, jData replaces data currently saved
    private func update(key: String, jData: String) -> Result {
        let res = updateListJson(key: key, jData: jData)
        
        if res.error != nil {
            return res
        } else {
            Storage.defaults.set(jData, forKey: key)
        }

        return Result(data: true)
    
    }
    
    /// Check if given list is empty
    private func isListEmpty(key: String, list: Any?) -> Bool {
        switch key {
        case "user":
            if let l = list as? [UserData] {
                return l.isEmpty
            }
        case "room":
            if let l = list as? [RoomData] {
                return l.isEmpty
            }
        case "message":
            if let l = list as? [MessageData] {
                return l.isEmpty
            }
        default:
            assertionFailure("No specified key in storage list")
        }
        return false
    }
    
    /// Create new UD with or without data, adds data to Storage
    private func createNewStorage(key: String, jData: String? = nil) -> Result {
        if let _ = Storage.defaults.string(forKey: key) {
            return Result(error: ErrorCodes(ErrorCode.Conflict))
        } else {
            if jData != nil {
                let res = updateListJson(key: key, jData: jData!)
                if res.error != nil {
                    return res
                }
                Storage.defaults.set(jData!, forKey: key)
                
            } else {
                Storage.defaults.set("", forKey: key)
            }
            return Result(data: true)
        }
    }
    
    /// Get list from UD by key
    ///
    /// ## Returns
    /// Data: true
    /// Errors: Conflict (storage already created) or BadRequest (key not matching)
    private func getStorage(key: String) -> Result {
        if let storage = Storage.defaults.string(forKey: key) {
            
            return Result(data: storage)
        } else {
            if key == "user" || key == "room" || key == "message" {
                let res = createNewStorage(key: key)
                if res.error != nil {
                    
                    // Conflict
                    return res
                }
                return Result(data: true)
            } else {
                return Result(error: ErrorCodes(ErrorCode.NotImplemented,
                                                message: "No specified key has been set. Key: \(key)"))
            }
        }
    }
    
    
    
    /// Get desired list from Storage
    private func getList(key: String) -> Result {
        switch key {
            case "user": if let list = self.users {
                return Result(data: list)
            } else {
                self.users = []
                return Result(data: [])
            }
            case "room": if let list = self.rooms {
                return Result(data: list)
            } else {
                self.rooms = []
                return Result(data: [])
            }
            case "message": if let list = self.messages {
                return Result(data: list)
            } else {
                self.messages = []
                return Result(data: [])
            }
        default: return Result(error: ErrorCodes(ErrorCode.NotImplemented,
                                                 message: "No specified key has been set. Key: \(key)"))
        }
    }
    
    /// Update list in Storage using JSON data
    private func updateListJson(key: String, jData: String) -> Result {
        switch key {
        case "user":
            let data: [UserData]? = instantiate(jsonString: jData)
            if let u = data {
                self.users = u
                return Result(data: u)
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed"))
            }
        case "room":
            let data: [RoomData]? = instantiate(jsonString: jData)
            if let r = data {
                self.rooms = r
                return Result(data: r)
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed"))
            }
        case "message":
            let data: [MessageData]? = instantiate(jsonString: jData)
            if let m = data {
                self.messages = m
                return Result(data: m)
            } else {
                return Result(error: ErrorCodes(ErrorCode.InternalServerError,
                                                message: "Json to list didn't succeed"))
            }
        default:
            return Result(error: ErrorCodes(ErrorCode.NotImplemented,
                                            message: "No specified key has been set. Key: \(key)"))
        }
    }
    
    /// Get prepared data from Storage
    /// - get data from UD
    ///     - !data is not in UD and key allowed
    ///         - create new
    ///     - data is in UD
    ///         - update Storage
    ///         - return list required (empty or full)
    private func getReloadedData(key: String) -> Result {
        let res = getStorage(key: key)
        if res.error != nil {
            return res
        } else {
            return updateListJson(key: key, jData: res.data as! String)
        }
    }
}

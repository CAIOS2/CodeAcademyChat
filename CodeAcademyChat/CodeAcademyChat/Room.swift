//
//  Room.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-08.
//

import Foundation

//// Room is created and then is saved to UserDefaults
//// When user logs in all assigned rooms to the user are obtained
//// from the UserDefaults
//// UserDefaults contain all rooms and their data excluding messages
//    // room contain list of messages id's tied with UserDefaults containing messages
//// UserDefaults contain all messages and associated rooms
//
//// ------- Room --------
//// key: UserDefaults key (String)
//// roomName: String
//// onlineUsers: [String]
//// offlineUsers: [String]
//// messagesKeys: [String]
//
//
//class Room {
//    let key: String
//    let roomName: String
//    var onlineUsers: Int
//    var offlineUsers: Int
//    var messageHistory: [String]
    
//    static instance Room
    
//    init(roomName: String) {
        
        
        
//        self.roomName = roomName
//        if let j = UserData.defaults.array(forKey: "room-\(self.roomId)") {
//            self.messages = j as! [String]
//        } else {
//            UserData.defaults.set([], forKey: "room-\(roomId)")
//            self.messages = []
//        }
        
        
        
        
//    }
    
//    func addMessage(message: Message) -> [String] {
//        if var j = UserData.defaults.array(forKey: "room-\(roomId)") {
//            j.append(message.collect())
//            UserData.defaults.set(j, forKey: "room-\(roomId)")
//        } else {
//            UserData.defaults.set([message], forKey: "room-\(roomId)")
//        }
//        self.messages.append(message.collect())
//        return self.messages
//    }
//
//    func printMessages() {
//        for each in self.messages {
//            print(each)
//        }
//    }
//
//    func getMessages() -> [String] {
//        return self.messages
//    }
//}

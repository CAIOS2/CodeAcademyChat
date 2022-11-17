//
//  Message.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

struct MessageOpenData {
    let uuid: String
    let message: String
    let username: String
    let date: Date
}

struct MessageData: Decodable, Encodable {
    let uuid: String
    let encryptedMessage: String
    let encryptedUsername: String
    let date: Date
    
    init(message: String, username: String, key: [UInt8]) throws {
        self.uuid = UUID().uuidString
        self.encryptedMessage = try aes.encrypt(data: message, key: key)
        self.encryptedUsername = try aes.encrypt(data: message, key: key)
        self.date = Date.now
    }
    
    func show(using key: [UInt8]) throws -> MessageOpenData {
        return MessageOpenData(
            uuid: self.uuid,
            message: try aes.decrypt(data: self.encryptedMessage, key: key),
            username: try aes.decrypt(data: self.encryptedUsername, key: key),
            date: self.date
        )
    }
    
    // in order to get all messages that were written only using the same account
    // encrypt username with key
    // find all messages written by the encrypted username
    
    // to add a message -> Storage.add(to: key, data: MessageData)
    
}

//
//  Message.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation
import CryptoKit

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
    
    init(message: String, username: String, symKey: SymmetricKey) {
        self.uuid = UUID().uuidString
        self.encryptedMessage = Encryptor.encrypt(symKey: symKey, data: message)
        self.encryptedUsername = Encryptor.encrypt(symKey: symKey, data: username)
        self.date = Date.now
    }
    
    func show(using symKey: SymmetricKey) -> MessageOpenData {
        return MessageOpenData(
            uuid: self.uuid,
            message: Encryptor.decrypt(symKey: symKey, data: self.encryptedMessage),
            username: Encryptor.decrypt(symKey: symKey, data: self.encryptedUsername),
            date: self.date
        )
    }
    
    // in order to get all messages that were written only using the same account
    // encrypt username with key
    // find all messages written by the encrypted username
    
    // to add a message -> Storage.add(to: key, data: MessageData)
    
}

//class Message {
//    let data: MessageData
//
//    init(message: String, username: String) {
//        self.data = MessageData(
//            uuid: UUID().uuidString,
//            message: message,
//            username: username,
//            date: Date.now
//        )
//    }
//
//    func
//
//
//}

//
//  Encryption.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-12.
//

import Foundation
import CryptoKit

class Encryptor {
    
    static func encrypt(key: String, data: String) -> String {
        return Encryptor.encrypt(symKey: prepareKey(key: key), data: data)
    }
    
    static func encrypt(symKey: SymmetricKey, data: String) -> String {
        // TODO: create .env
        let iv = ">YZ1rq!@#agnost1heev3421"
        
        
        let preparedData: Data? = data.data(using: .utf8)
        
        let sealedBoxData = try! ChaChaPoly.seal(preparedData!, using: symKey).combined
        let encryptedString = sealedBoxData.base64EncodedString()
        
        return encryptedString
    }
    
    static func decrypt(key: String, data: String) -> String {
        return Encryptor.encrypt(symKey: prepareKey(key: key), data: data)
    }
    
    static func decrypt(symKey: SymmetricKey, data: String) -> String {
        // TODO: create .env
        let iv = ">YZ1rq!@#agnost1heev3421"
        
        let cipherData = Data(base64Encoded: data, options: .ignoreUnknownCharacters)
        
        let box = try! ChaChaPoly.SealedBox(combined: cipherData!)
        
        box.tag.withUnsafeBytes {
            return Data(Array($0)).base64EncodedString()
        }
        
        let res = try! ChaChaPoly.open(box, using: symKey)
        return String(data: res, encoding: .utf8)!
    }
    
    static func prepareKey(key: String) -> SymmetricKey {
        guard let symKey = SymmetricKey(base64EncodedString: key) else {
            precondition(false, "Deserialization of symmetric key failed. res = nil")
        }
        return symKey
    }
    
    static func createKey() -> String {
        let symKey: SymmetricKey = SymmetricKey(size: .bits256)
        return symKey.serialize()
    }
    
    static func createKey(password: String) -> String {
        return Hashing.hash(password)
    }
}

extension SymmetricKey {
    init?(base64EncodedString: String) {
        guard let data = Data(base64Encoded: base64EncodedString) else {
            return nil
        }
        
        self.init(data: data)
    }
    
    func serialize() -> String {
        return self.withUnsafeBytes {
            return Data(Array($0)).base64EncodedString()
        }
    }
}

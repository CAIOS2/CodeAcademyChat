//
//  Encryption.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-12.
//
//  Check https://github.com/krzyzanowskim/CryptoSwift#basics

import Foundation
import CryptoSwift

let iv = Array("secivvec".utf8)
let aes = AESCipher()

class AESCipher {

    
    /// Encrypts data as text to UTF8
    /// Data is in UTF8
    /// Key is in hexString
    func encrypt(data: String, key: String) throws -> String {
        
        do {
            let aes = try AES(key: Array<UInt8>(hex: key), blockMode: CBC(iv: iv), padding: .pkcs7)
            let input: Data = data.data(using: .utf8)!
            let encBytes: [UInt8] = try aes.encrypt(input.bytes)
            return encBytes.toUTF8()
        } catch let e as NSError {
            print("encrypt")
            print(e.self)
            throw e
        }
        
//        let aes = try AES(key: Array<UInt8>(hex: key), blockMode: CBC(iv: iv), padding: .pkcs7)
//        let input: Data = data.data(using: .utf8)!
//        let encBytes: [UInt8] = try aes.encrypt(input.bytes)
//        return encBytes.toUTF8()
    }
    
    /// Encrypts data as text to UTF8
    /// Data is in UTF8
    func encrypt(data: String, key: [UInt8]) throws -> String {
        
        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let input: Data = data.data(using: .utf8)!
            let encBytes: [UInt8] = try aes.encrypt(input.bytes)
            return encBytes.toUTF8()
        } catch let e as NSError {
            print("encrypt")
            print(e.self)
            throw e
        }
        
//        let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
//        let input: Data = data.data(using: .utf8)!
//        let encBytes: [UInt8] = try aes.encrypt(input.bytes)
//        return encBytes.toUTF8()
    }
    
    /// Decrypts data as UTF8 string to text output
    /// Key is in hexString
    /// Data is in UTF8
    func decrypt(data: String, key: String) throws -> String {
        
        do {
            let aes = try AES(key: Array<UInt8>(hex: key), blockMode: CBC(iv: iv), padding: .pkcs7)
            let input: Data = data.data(using: .utf8)!
            let decBytes: [UInt8] = try aes.decrypt(input.bytes)
            return decBytes.toUTF8()
        } catch let e as NSError {
            print("decrypt")
            print(e.self)
            throw e
        }
        
//        let aes = try AES(key: Array<UInt8>(hex: key), blockMode: CBC(iv: iv), padding: .pkcs7)
//        let input: Data = data.data(using: .utf8)!
//        let decBytes: [UInt8] = try aes.decrypt(input.bytes)
//        return decBytes.toUTF8()
    }
    
    /// Encrypts data as text to UTF8
    /// Data is in UTF8
    func decrypt(data: String, key: [UInt8]) throws -> String {
        
        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let input: Data = data.data(using: .utf8)!
            let decBytes: [UInt8] = try aes.decrypt(input.bytes)
            return decBytes.toUTF8()
        } catch let e as NSError {
            print("decrypt")
            print(e.self)
            throw e
        }
        
//        let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
//        let input: Data = data.data(using: .utf8)!
//        let decBytes: [UInt8] = try aes.decrypt(input.bytes)
//        return decBytes.toUTF8()
    }
    
    func createKey(password: String, username: String) throws -> String {
        let passArray: [UInt8] = Array(password.utf8)
        let salt: [UInt8] = Array(username.utf8)
        
        return try createKey(password: passArray, salt: salt)
            .toHexString()
    }
    
    func createKey(password: String, username: String) throws -> [UInt8] {
        let passArray: [UInt8] = Array(password.utf8)
        let salt: [UInt8] = Array(username.utf8)
        
        return try createKey(password: passArray, salt: salt)
    }
    
    func createKey(password: [UInt8], salt: [UInt8]) throws -> [UInt8] {
        let key = try PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: 4096,
            keyLength: 32, /* AES-256 */
            variant: .sha2(.sha256)
        ).calculate()
        
        return key
    }
    
    func createKey() throws -> String {
        let passArray: [UInt8] = Array(Random.string(length: 8).utf8)
        let salt: [UInt8] = Array(Random.string(length: 8).utf8)
        
        return try createKey(password: passArray, salt: salt)
            .toHexString()
    }
    
    func createKey() throws -> [UInt8] {
        let passArray: [UInt8] = Array(Random.string(length: 8).utf8)
        let salt: [UInt8] = Array(Random.string(length: 8).utf8)
        
        return try createKey(password: passArray, salt: salt)
    }
}


let decrypted: [UInt8] = [0x48, 0x65, 0x6c, 0x6c, 0x6f]


extension [UInt8] {
    func toUTF8() -> String {
        let data = Data(self)
        let string = String(data: data, encoding: .utf8)!
        return string
    }
}

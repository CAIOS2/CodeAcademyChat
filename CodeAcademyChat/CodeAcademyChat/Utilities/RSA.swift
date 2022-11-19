//
//  RSA.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-19.
//
//  Check https://github.com/TakeScoop/SwiftyRSA

import SwiftyRSA
import Foundation

class RSA {
    
    /// Creates RSA2048 key pair
    func createKeyPair() throws -> (privateKey: PrivateKey, publicKey: PublicKey) {
        return try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
    }
    
    /// Creates RSA2048 key pair as Base64
    func createKeyPair() throws -> (privateKey: String, publicKey: String) {
        let keys = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
        return (
            privateKey: try keys.privateKey.base64String(),
            publicKey: try keys.publicKey.base64String()
        )
    }
    
    /// Encrypts data with RSA2048 to return as Data
    func encrypt(publicKeyBase64: String, data: String) throws -> Data {
        let publicKey = try PublicKey(base64Encoded: publicKeyBase64)
        return try encrypt(publicKey: publicKey, data: data)
    }
    
    /// Encrypts data with RSA2048 to return as Base64
    func encrypt(publicKeyBase64: String, data: String) throws -> String {
        let publicKey = try PublicKey(base64Encoded: publicKeyBase64)
        return try encrypt(publicKey: publicKey, data: data)
    }
    
    /// Encrypts data with RSA2048 to return as Data
    func encrypt(publicKey: PublicKey, data: String) throws -> Data {
        let clearMessage = try ClearMessage(string: data, using: .utf8)
        let encrypted = try clearMessage.encrypted(with: publicKey, padding: .PKCS1)
        return encrypted.data
    }
    
    /// Encrypts data with RSA2048 to return as Base64
    func encrypt(publicKey: PublicKey, data: String) throws -> String {
        let clearMessage = try ClearMessage(string: data, using: .utf8)
        let encrypted = try clearMessage.encrypted(with: publicKey, padding: .PKCS1)
        return encrypted.base64String
    }
    
    /// Decrypt data with RSA2048 to return as Data
    func decrypt(privateKey: PrivateKey, dataBase64: String) throws -> Data {
        let encryptedMessage = try EncryptedMessage(base64Encoded: dataBase64)
        let clearMessage = try encryptedMessage.decrypted(with: privateKey, padding: .PKCS1)
        
        return clearMessage.data
    }
    
    /// Decrypt data with RSA2048 to return as Base64
    func decrypt(privateKey: PrivateKey, dataBase64: String) throws -> String {
        let encryptedMessage = try EncryptedMessage(base64Encoded: dataBase64)
        let clearMessage = try encryptedMessage.decrypted(with: privateKey, padding: .PKCS1)
        
        return clearMessage.base64String
    }
    
    /// Decrypt data with RSA2048, accepting privateKey as Base64 to return as Data
    func decrypt(privateKey: String, dataBase64: String) throws -> Data {
        return try decrypt(
            privateKey: try PrivateKey(base64Encoded: privateKey),
            dataBase64: dataBase64
        )
    }
    
    /// Decrypt data with RSA2048, accepting privateKey as Base64 to return as Base64
    func decrypt(privateKey: String, dataBase64: String) throws -> String {
        return try decrypt(
            privateKey: try PrivateKey(base64Encoded: privateKey),
            dataBase64: dataBase64
        )
    }
}

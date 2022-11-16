//
//  PasswordHashing.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-05.
//

import Foundation
import CryptoKit

enum SHA {
    case SHA512, SHA256
}

class Hashing {
    static func hash(_ password: String) -> String {
        let data = password.data(using: .utf8)!
        let hashDigest = SHA512.hash(data: data)
        let stringHash: String = hashDigest.description

        return String(stringHash.dropFirst(15))
    }
    
    static func verify(hash: String, password: String) -> Bool {
        guard hash != Hashing.hash(password) else {
            return true
        }
        return false
    }
    
    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

}

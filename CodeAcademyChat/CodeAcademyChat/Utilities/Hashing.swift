//
//  PasswordHashing.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-05.
//

import Foundation
import CryptoKit

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
}

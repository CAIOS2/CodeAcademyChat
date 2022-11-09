//
//  User.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class User {
    let name: String
    let password: String
    var isOnline: Bool
    
    init(name: String, password: String, isOnline: Bool) {
        self.name = name
        self.password = password
        self.isOnline = isOnline
    }
}

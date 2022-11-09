//
//  UserResult.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

struct UserResult {
    let user: User?
    let errorMessage: String?
    
    init(user: User?, errorMessage: String?) {
        self.user = user
        self.errorMessage = errorMessage
    }
}

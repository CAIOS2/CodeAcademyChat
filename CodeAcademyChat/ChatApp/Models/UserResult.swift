//
//  UserResult.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

struct UserResult {
    let user: User?
    let errorTitle: String?
    let errorMessage: String?
    
    init(user: User?, errorTitle: String?, errorMessage: String?) {
        self.user = user
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        
    }
}

//
//  Error.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-10.
//

import Foundation

enum ErrorCode: String {
    case NotFound
    case Conflict
    case BadRequest
    case Unauthorized
    case NotImplemented
    case InternalServerError
}

struct ErrorCodes {
    let code: ErrorCode
    var message: String? = nil
    
    init(_ code: ErrorCode, message: String? = nil) {
        self.code = code
        if message != nil {
            self.message = message!
        }
    }
    
    func getCode() -> Int {
        switch (self.code) {
        case .Conflict: return 409
        case .NotFound: return 404
        case .BadRequest: return 400
        case .Unauthorized: return 401
        case .InternalServerError: return 500
        case .NotImplemented: return 501
        }
    }
    
    func getString() -> String {
        if let messageString = self.message {
            return "\(code.rawValue). \(String("Message: \(messageString).")) Code: \(getCode())"
        } else {
            return "\(code.rawValue). Code: \(getCode())"
        }
    }
}

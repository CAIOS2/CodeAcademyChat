//
//  Error.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-09.
//

import Foundation

struct Result {
    let data: Any?
    let error: Any?
    
    init(data: Any? = nil, error: Any? = nil) {
        if let dt = data {
            self.data = dt
        } else {
            if let er = error {
                self.error = er
            }
        }
        preconditionFailure("No data or error")
    }
}

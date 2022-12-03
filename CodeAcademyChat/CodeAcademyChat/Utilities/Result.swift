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
        var d: Any? = nil
        var e: Any? = nil
        
        if let dt = data {
            d = dt
        } else {
            if let er = error {
                e = er
            }
        }
        self.data = d
        self.error = e
    }
}

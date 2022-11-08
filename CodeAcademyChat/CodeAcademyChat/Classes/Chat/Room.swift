//
//  Room.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-08.
//

import Foundation

class Room {
    let datetime: Date
    let id: String
    
    init(datetime: Date, id: String) {
        self.datetime = datetime
        self.id = id
    }
}

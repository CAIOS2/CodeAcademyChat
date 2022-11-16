//
//  Room.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class Room {
  let name: String
  var messages: [Message]
  
  init(name: String, messages: [Message]) {
    self.name = name
    self.messages = messages
  }
}

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
  
  init(name: String, messages: [Message], writeMessage: String) {
    self.name = name
    self.messages = messages
  }
  
  func writeMessage(message: String, username: User) {
    var message = Message(content: message, date: .now, userName: username.name)
    messages.append(message)
  }
}

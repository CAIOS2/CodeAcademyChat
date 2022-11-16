//
//  Message.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import Foundation

class Message {
  var content: String
  let date: Date
  let userName: String
  
  init(content: String, date: Date, userName: String) {
    self.content = content
    self.date = date
    self.userName = userName
  }
}

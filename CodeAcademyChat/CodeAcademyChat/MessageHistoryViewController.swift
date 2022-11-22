//
//  MessageHistoryViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-22.
//

import UIKit

class MessageHistoryViewController: UIViewController {
    
    @IBOutlet weak var messageHistoryTableView: UITableView!
    
    var currentUserMessages: [RoomMessage] = []
    var currentUserMessagesStrings: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserMessages()
        
        messageHistoryTableView.frame = self.view.frame
        messageHistoryTableView.dataSource = self
        
        messageHistoryTableView.register(UINib(nibName: "ViewMessageHistoryCell", bundle: nil), forCellReuseIdentifier: "historyMessage")
    }
    
    func getCurrentUserMessages() {
        var allMessages: [RoomMessage] = []
        if let rooms = sharedDataManager.userJoinedRooms {
            for room in rooms {
                if let messages = room.messages {
                    for each in messages {
                        allMessages.append(each)
                    }
                }
            }
        } else {
            currentUserMessages = []
            return
        }
        for each in allMessages {
            if each.roomUser.username == sharedDataManager.currentUsername! {
                currentUserMessages.append(each)
            }
        }
    }
    
    
}
extension MessageHistoryViewController: UITableViewDataSource {
        /// Returns ammount of table rows required for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /// Creates cells for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyMessage", for: indexPath) as! HistoryMessageViewCell

        cell.messageLabel.text = "Date: \nMessage:"
        
        return cell
    }
}

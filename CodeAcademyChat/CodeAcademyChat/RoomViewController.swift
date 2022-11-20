//
//  RoomViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-16.
//

import UIKit

class RoomViewController: UIViewController {
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesListView: UITableView!
    
    var messagesList: [RoomMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sharedDataManager.currentRoom!.messages != nil {
            messagesList = sharedDataManager.currentRoom!.messages!
            print(messagesList.count)
        }
        
        
        roomIdLabel.text! = sharedDataManager.currentRoom!.data.roomName
        
        messagesListView.frame = self.view.frame
        messagesListView.dataSource = self
        messagesListView.register(UINib(nibName: "ViewMessageRight", bundle: nil), forCellReuseIdentifier: "messageRight")
        messagesListView.register(UINib(nibName: "ViewMessageLeft", bundle: nil), forCellReuseIdentifier: "messageLeft")
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        writeMessage()
        self.messagesListView.reloadData()
    }
    
    func writeMessage() {
        if messageTextField.hasText {
            do {
                try sharedDataManager.currentRoom!.addMessage(
                    message: messageTextField.text!,
                    username: sharedDataManager.currentUsername!
                )
                messagesList = sharedDataManager.currentRoom!.messages!
            } catch let e as NSError {
                print(e.self)
                showError(e.domain)
            }
        } else {
            // Empty Message
        }
    }
    
    func showError(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

extension RoomViewController: UITableViewDataSource {
    /// Returns ammount of table rows required for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    /// Creates cells for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ms = messagesList
        ms.reverse()
        if ms[indexPath.row].isMessageSentByUser() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageRight", for: indexPath) as! RightMessageViewCell
            cell.usernameLabel.text! = ms[indexPath.row].prepareUsername()
            cell.dateTimeLabel.text! = ms[indexPath.row].prepareDate()
            cell.messageTextLabel.text! = ms[indexPath.row].message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageLeft", for: indexPath) as! LeftMessageViewCell
            cell.usernameLabel.text! = ms[indexPath.row].prepareUsername()
            cell.dateTimeLabel.text! = ms[indexPath.row].prepareDate()
            cell.messageTextLabel.text! = ms[indexPath.row].message
            return cell
        }
        
        
    }
}

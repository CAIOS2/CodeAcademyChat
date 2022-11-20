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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomIdLabel.text! = sharedDataManager.currentRoom!.data.roomName
        
        if sharedDataManager.currentRoom!.messages != nil {
            // Do any additional setup after loading the view.
            if !sharedDataManager.currentRoom!.messages!.isEmpty {
                messagesListView.dataSource = self
                messagesListView.register(UINib(nibName: "ViewMessageRight", bundle: nil), forCellReuseIdentifier: "messageRight")
                messagesListView.register(UINib(nibName: "ViewMessageLeft", bundle: nil), forCellReuseIdentifier: "messageLeft")
            }
           
        }
        
    }
    
    func updateTableView() {
        if let res = sharedDataManager.storage.get(by: "message") {
            print((res as! [MessageData]).toJSONString())
        }
        
        if let res = sharedDataManager.storage.get(by: "room") {
            print((res as! [RoomData]).toJSONString())
        }
        if let res = sharedDataManager.storage.get(by: "user") {
            print((res as! [UserData]).toJSONString())
        }
        
        if sharedDataManager.currentRoom!.messages != nil {
            // Do any additional setup after loading the view.
//            if !sharedDataManager.currentRoom!.messages!.isEmpty {
                messagesListView.dataSource = self
                messagesListView.register(UINib(nibName: "ViewMessageRight", bundle: nil), forCellReuseIdentifier: "messageRight")
                messagesListView.register(UINib(nibName: "ViewMessageLeft", bundle: nil), forCellReuseIdentifier: "messageLeft")
//            } else {
//                print("its empty")
//            }
            
        } else {
            print("its nil")
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        writeMessage()
    }
    
    func writeMessage() {
        if messageTextField.hasText {
            do {
                if let messages = sharedDataManager.storage.get(by: "message") as? [MessageData] {
                    for each in messages {
                        do {
                            var text = try rabbit.encrypt(data: "test", key: sharedDataManager.currentRoom!.key)
                            print(text)
                            text = try rabbit.decrypt(hex: text, key: sharedDataManager.currentRoom!.key)
                            print(text)
                            let message = try rabbit.decrypt(hex: each.encryptedMessage, key: sharedDataManager.currentRoom!.key)
                            let username = try rabbit.decrypt(hex: each.encryptedUsername, key: sharedDataManager.currentRoom!.key)
                            print("Message: \(message)\nUsername: \(username)\n")
                        } catch let e as NSError {
                            showError(e.domain)
                        }
                    }
                }
                
                try sharedDataManager.currentRoom!.addMessage(
                    message: messageTextField.text!,
                    username: sharedDataManager.currentUsername!
                )
                updateTableView()
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
        if sharedDataManager.currentRoom!.messages != nil {
//            if !sharedDataManager.currentRoom!.messages!.isEmpty {
                return sharedDataManager.currentRoom!.messages!.count
//            }
        }
        return 0
    }
    
    /// Creates cells for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ms = sharedDataManager.currentRoom!.messages!
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

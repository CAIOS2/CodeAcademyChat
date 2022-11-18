//
//  RoomViewController.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-15.
//

import UIKit

class RoomViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var room: Room!
    var currentUser: User!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        messageTextView.text = room.messages
        
        
        // Do any additional setup after loading the view.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeLabel.text = "Welcome to \(room.name)"
    }
    
    private func updateMessagesTextView(){
        // 1 Variantas
//        var joinedString = ""
//
//        for sentMessage in room.messages {
//            joinedString +=
//                            """
//                            Date: \(sentMessage.date)
//
//                            User: \(sentMessage.username)
//
//                            Message: \(sentMessage.content)
//                            """
//            if room.messages.last?.date != sentMessage.date {
//                joinedString += "\n" + "-----------------" + "\n\n"
//            } else {
//                joinedString += "\n"
//            }
//        }
//        messageTextView.text = joinedString
        
        // 2 Variantas
        
//        var messageContent = [String]()
//
//        for sentMessage in room.messages {
//            let content =
//                """
//                Date: \(sentMessage.date)
//
//                User: \(sentMessage.username)
//
//                Message: \(sentMessage.content)
//                """
//            messageContent.append(content)
//        }
//
//        messageTextView.text = messageContent.joined(separator: "\n----------------- \n\n")
        
        // 3 variantas
        
        let messageContent = room.messages.map {
            
                            """
                            Date: \($0.date)
                            
                            User: \($0.username)
                            
                            Message: \($0.content)
                            """
        }
                messageTextView.text = messageContent.joined(separator: "\n----------------- \n\n")

    }
    
    @IBAction func didTapButton(_ sender: Any) {

        room.writeMessage(messageContent: messageTextField.text!, sender: currentUser)
        updateMessagesTextView()
        

    }
    
    
    
    

}

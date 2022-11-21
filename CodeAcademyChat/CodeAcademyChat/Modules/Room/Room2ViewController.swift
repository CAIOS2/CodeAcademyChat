//
//  Room2ViewController.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-15.
//

import UIKit

class Room2ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var messagesTextView: UITextView!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var currentUser: User!
    var room: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        welcomeLabel.text = "Welcome to \(room.name)"
    }
    
    private func updateMessagesTextField() {
        var messageContents = [String]()
        
        for message in room.messages {
            let content =
            """
            Date: \(message.date)
            
            User: \(message.username)
            
            Message: \(message.content)
            """
            messageContents.append(content)
        }
        
        messagesTextView.text = messageContents.joined(separator: "\n------------ \n\n")
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        room.writeMessage(messageContent: messagesTextField.text!, sender: currentUser)
        updateMessagesTextField()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

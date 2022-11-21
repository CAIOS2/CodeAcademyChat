//
//  RoomViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-14.
//

import UIKit

class RoomViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var currentUser: User!
    var currentRoom: Room!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoomMesssages()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helloLabel.text = "Room: \(currentRoom.name)"
        
    }
    
    func getRoomMesssages() {
        //        let messageList = currentRoom.getMessages()
        //  print(messageList)
        
        var messageList: [String] = []
        for message in currentRoom.messages {
            let fullMessage =   """
                                Date: \(message.datetime) \n
                                User: \(message.username) \n
                                Message: \(message.content)\n
                                
                                """
            messageList.append(fullMessage)
        }
        textArea.text = messageList.joined(separator: "-- -- -- -- -- -- -- \n \n")
    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if let newMessage = messageTextField {
            currentRoom.writeMessage(messageContent: newMessage.text!, sender: currentUser)
            
            getRoomMesssages()
            
            
            
            
        }
        
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

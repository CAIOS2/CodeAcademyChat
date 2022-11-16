//
//  RoomViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-16.
//

import UIKit

class RoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var messagesFields: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        prepareMessageList()
    }
    
    func prepareMessageList() {
        var completeMessages: String = ""
        let res = sharedDataManager.currentRoom!.0.messages
        
        if let ms = res {
            for m in ms {
                completeMessages += prepareMessage(message: m)
            }
        } else {
            messagesFields.text! = "New Chat"
        }
        messagesFields.text! = completeMessages
        
    }
    
    func prepareMessage(message: RoomMessage) -> String {
        var status = "🟢"
        if !message.roomUser.online {
            status = "🔴"
        }
        
        var messageSide = "<"
        if message.roomUser.username != sharedDataManager.currentUsername {
            messageSide = ">"
        }
        
        return """
        \(messageSide)
        \(message.roomUser.username) -> \(status)
        \(message.message)
        \(message.date)
        
        """+"\(n)"
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

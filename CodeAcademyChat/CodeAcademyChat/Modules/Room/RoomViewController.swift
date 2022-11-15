//
//  RoomViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-10.
//

import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var currentUser: User!
    var room: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //welcomeLabel.text = "Welcome to \(room.name)"
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

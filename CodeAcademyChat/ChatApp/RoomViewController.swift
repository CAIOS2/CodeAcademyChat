//
//  RoomViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 14/11/2022.
//

import UIKit

class RoomViewController: UIViewController {
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var messageTextView: UITextView!
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet weak var sendButton: UIButton!
  
  
  var property_currentUser: User!
  var property_room: Room!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //Sutvarkyti
    navigationController?.setNavigationBarHidden(false, animated: true)
    welcomeLabel.text = "Welcome to \(property_room.name)"
  }
  
  @IBAction func sendButtonTapped(_ sender: UIButton) {
    
  }
  
  
  
}

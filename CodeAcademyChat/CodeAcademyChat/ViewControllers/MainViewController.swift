//
//  MainViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class MainViewController: UIViewController {

    var loggedUserName: User!
    var userForSegue: User!
    var roomManager = RoomManager()
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var newRoomIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = ""
        errorMessage.isHidden = true
        // Do any additional setup after loading the view.

            
        self.navigationItem.setHidesBackButton(true, animated: false)
        print("main view controller opened")
      //  helloLabel.text = "Hello, \(loggedUserName)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helloLabel.text = "Hello, \(loggedUserName.username)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.loggedUserName = userForSegue
            }
        }
    }
    
    
    

    @IBAction func actionJoinRoom(_ sender: Any) {
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        
        let alertController = UIAlertController(title: "Error joining room", message: "Room not found", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    
    @IBAction func actionCreateNewRoom(_ sender: Any) {
        
  //      print("aaa")
  //      roomManager.printRoomList()

        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:  { _ in
            guard let newRoomID = self.newRoomIDTextField.text  else {
                return
            }

            let newRoom = self.roomManager.addRoom(newName: newRoomID)
            self.roomManager.printRoomList()   //to test
            
            let roomViewController = RoomViewController()
            
            roomViewController.currentRoom = newRoom.room
            roomViewController.currentUser = self.loggedUserName
            
            self.show(roomViewController, sender: nil)
            self.navigationController?.present(roomViewController, animated: true)
        }
                                        
                                        
        )
        let alertController = UIAlertController(title: "Error creating new room", message: "is some issues", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    
    
    
    
    
    

    
    
    
    @IBAction func actionShowOnlineUsers(_ sender: Any) {
        
        let alerAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: "Online users:", message: "must_be_online_user_list", preferredStyle: .alert)
        
        alertController.addAction(alerAction)
        self.present(alertController, animated: true)
        
    }
    
    @IBAction func actionShowOfflineUsers(_ sender: Any) {
        let alerAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: "Online users:", message: "must_be_offline_user_list", preferredStyle: .alert)
        
        alertController.addAction(alerAction)
        self.present(alertController, animated: true)
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    @IBAction func actionSettings(_ sender: Any) {
        userForSegue = loggedUserName
    }
    
}





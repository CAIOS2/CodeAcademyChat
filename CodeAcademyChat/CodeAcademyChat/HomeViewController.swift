//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var helloUsername: UILabel!
    @IBOutlet weak var roomNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        helloUsername.text = "Hello, \(sharedDataManager.currentUsername!)"
        navigationController?
            .setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func showOnlineUsersButton(_ sender: Any) {
        showListOfUsers(online: true)
    }
    @IBAction func showOfflineUsersButton(_ sender: Any) {
        showListOfUsers(online: false)
    }
    
    func showListOfUsers(online: Bool) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        sharedDataManager.getOnlineOfflineUsers()
        
        var title = "Online users"
        var message = ""
        if !online {
            title = "Offline users"
            for each in sharedDataManager.offlineUsers! {
                message += "\n\(each.username)"
            }
        } else {
            for each in sharedDataManager.onlineUsers! {
                message += "\n\(each.username)"
            }
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
    
    @IBAction func joinRoom(_ sender: Any) {
        if roomNameTextField.text! != "" {
            do {
                sharedDataManager.currentRoom = try sharedDataManager.user!.joinRoom(roomName: roomNameTextField.text!)
                
                
                
                let res = defaults.string(forKey: "message")
                let list = instantiate(jsonString: res!) as [MessageData]?
                print("Printing")
                if let messages = list {
                    for each in messages {
                        print(each.uuid)
                        print(
                            try rabbit.decrypt(
                                hex: each.encryptedMessage,
                                key: try rabbit.createKey(
                                    password: roomNameTextField.text!,
                                    username: roomNameTextField.text!
                                ) as [UInt8]
                            ) as String
                        )
                        print(
                            try rabbit.decrypt(
                                hex: each.encryptedUsername,
                                key: try rabbit.createKey(
                                    password: roomNameTextField.text!,
                                    username: roomNameTextField.text!
                                ) as [UInt8]
                            ) as String
                        )
                        print(each.date)
                    }
                }
                
                
                
                performSegue(withIdentifier: "room", sender: nil)
            } catch let e as NSError {
                showError(e.domain)
            }
            
//            let res = sharedDataManager.userJoinedRooms
//            if let roomsAndKeys = res {
//                // there're rooms
//                var isRoomJoinedPreviously = false
//                for each in roomsAndKeys {
//                    if each.data.roomName == roomNameTextField.text! {
//                        sharedDataManager.currentRoom = each
//                        isRoomJoinedPreviously = true
//                        performSegue(withIdentifier: "room", sender: nil)
//                    }
//                }
//                if !isRoomJoinedPreviously {
//                    do {
//                        let updatedRoom = try sharedDataManager.user!.joinRoom(roomName: roomNameTextField.text!)
//                        sharedDataManager.currentRoom = Room(updatedRoom)
//                        performSegue(withIdentifier: "room", sender: nil)
//                    } catch let e as NSError {
//                        showError("No room with such id, \(e.domain)")
//                    }
//                }
//            } else {
//                showError("No rooms to join")
//            }
        } else {
            showError("Set the room id to join")
        }
    }
    
    
    @IBAction func createRoom(_ sender: Any) {
        if roomNameTextField.text! != "" {
            do {
                // (RoomData, [UInt8])
                try sharedDataManager.user!.createRoom(roomName: roomNameTextField.text!)
            } catch let e as NSError {
                showError(e.domain)
            }
        } else {
            showError("Provide room id first")
        }
    }
    
    

    @IBAction func logoutButton(_ sender: Any) {
        do {
            try sharedDataManager.logout()
        } catch let e as NSError {
            // Failed to change user online status
            showError(e.domain + " User online status")
        }
        self.navigationController?.popViewController(animated: true)
    }
    func setUserData(username: String) {
        
//        if let text = helloUsername.text {
//            helloUsername.text = text + username
//        }
    }
    
    func showError(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

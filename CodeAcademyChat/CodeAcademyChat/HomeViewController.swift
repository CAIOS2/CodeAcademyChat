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
        helloUsername.text = "Hello, \(sharedDataManager.currentUsername!)"
        navigationController?
            .setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
    @IBAction func joinRoom(_ sender: Any) {
        if roomNameTextField.text! != "" {
            let res = sharedDataManager.userJoinedRooms
            if let roomsAndKeys = res {
                // there're rooms
                for each in roomsAndKeys {
                    if each.data.roomName == roomNameTextField.text! {
                        sharedDataManager.currentRoom = each
                        performSegue(withIdentifier: "room", sender: nil)
                    }
                }
            } else {
                showError("No rooms to join")
            }
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

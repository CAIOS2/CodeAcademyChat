//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var roomIDfield: UITextField!
    
    let roomManager = RoomManager()
    
    var user: User!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        welcomeLabel.text = "Hello, \(user.username)"
    }
    
    @IBAction private func joinRoomTapped(_ sender: Any) {
        guard roomIDfield.text != "" else {
            print("empty room ID")
            return
        }
        let roomResult = roomManager.getRoom(roomName: roomIDfield.text!)
        
        if let room = roomResult.room {
            let roomViewController = RoomViewController()
            roomViewController.room = room
            show(roomViewController, sender: nil)
        } else {
            showAlert(title: "Error joining room", message: "Room not found")
        }
    }
    
    @IBAction private func createNewRoomTapped(_ sender: Any) {
        
        let roomViewController = RoomViewController()
        let roomResult = roomManager.createRoom(parameterRoomName: roomIDfield.text!)
        
        if let room = roomResult.room {
            roomViewController.room = room
        } else {
            print(roomResult.errorMessage)
            return
        }
        
        //show(roomViewController, sender: nil)
        navigationController?.present(roomViewController, animated: true)
    }
    
    @IBAction private func showOnlineUserTapped(_ sender: Any) {
        showAlert(title: "Online users:", message: "\(user.username)")
    }
    
    @IBAction private func showOfflineUserTapped(_ sender: Any) {
        showAlert(title: "Offline users:")
    }
    
    @IBAction private func logoutTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String = "") {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SettingsViewController {
            viewController.user = user
        }
    }
}

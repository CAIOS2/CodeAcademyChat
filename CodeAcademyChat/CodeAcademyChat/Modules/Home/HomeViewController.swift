//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
        
    @IBOutlet weak var IdTextField: UITextField!
    
    var user: User!
    let roomManager = RoomManager()
        
        override func loadView() {
            super.loadView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()


            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = true
            userLabel.text = "Welcome, \(user.username)"
        }
    
    @IBAction private func joinRoomTapped(_ sender: Any) {
        let roomViewController = Room2ViewController()
        let roomResult = roomManager.getRoom(roomName: IdTextField.text! )
        
        if let room = roomResult.room {
            roomViewController.room = room
            show(roomViewController, sender: nil)
        } else {
            showAlert(title: "Error joining room", message: roomResult.errorMessage!)
        }
    }
    @IBAction private func newRoomTapped(_ sender: Any) {
        let roomViewController = Room2ViewController()
        
        let roomResult = roomManager.createRoom(roomName: IdTextField.text!)

                 if let room = roomResult.room {
                     roomViewController.room = room
                     show(roomViewController, sender: nil)
                 } else {
                     showAlert(title: "Error creating room", message: roomResult.errorMessage!)
                 }
//        if let exists = roomResult.room {
//            roomViewController
//            showAlert(title: "Error creating room", message: "Room name already exists")
//        }
            }
    @IBAction private func onlineUsersTapped(_ sender: Any) {
        showAlert(title: "Online users:", message: "\(user.username)")
    }
    @IBAction private func offlineUsersTapped(_ sender: Any) {
        showAlert(title: "Offline users:", message: "")
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    private func showAlert(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.user = user
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

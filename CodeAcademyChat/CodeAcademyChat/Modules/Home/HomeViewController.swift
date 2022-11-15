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
    @IBOutlet weak var roomIdTextField: UITextField!
    
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        welcomeLabel.text = "Hello, \(user.username)"
    }
    
    // MARK: - Actions
    
    @IBAction private func joinRoomTapped(_ sender: Any) {
        let roomResult = roomManager.getRoom(roomName: roomIdTextField.text!)
        
        showAlert(title: "Error joining room", message: "Room not found")
    }
    
    //    Uzduotis nr 2
    //    * HomeViewControllery iskviesti RoomManager createRoom funkcija kai yra paspaudziamas "Create Room" mygtukas
    //    * Sukurta kambari priskirti RoomViewController properciui room ir parodyt roomo name labely
    @IBAction private func createNewRoomTapped(_ sender: Any) {
        // TODO: Reimplement error message
        //        showAlert(title: "Error creating room", message: "Room name can't be empty!")
        
        let roomViewController = RoomViewController()
        
        //roomIdTextField.text! -- kaip parametra roomNamePaduodam
        let roomResult = roomManager.createRoom(parameterRoomName: roomIdTextField.text!)
        
        if let room = roomResult.room {
            roomViewController.room = room
            show(roomViewController, sender: nil)
        } else {
            // FIXME: - show alert
            print(roomResult.errorMessage)
        }
        
        //roomViewController.room = ????????
        //        navigationController?.present(roomViewController, animated: true)
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
        if let viewController = segue.destination as? SettingsViewController { waefkawefwaefawefawefawef
            viewController.user = user
        }
    }
}

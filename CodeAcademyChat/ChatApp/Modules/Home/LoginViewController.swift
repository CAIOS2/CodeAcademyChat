//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet weak var roomIDTextField: UITextField!
  @IBOutlet weak var welcomeLabel: UILabel!
  
  let roomManage = RoomManager()
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
    welcomeLabel.text = "Hello, \(user.name.capitalized)!"
    
  }
  
  @IBAction func joinRoomTapped(_ sender: UIButton) {
    let roomViewController = RoomViewController()
    let joinRoom = roomManage.getRoom(parameter_roomName: roomIDTextField.text!)
    if let room = joinRoom.room {
      roomViewController.property_room = room
      roomViewController.property_currentUser = user
//      navigationController?.present(roomViewController, animated: true)
      show(roomViewController, sender: nil)
    } else {
      showAlert(title: "Error joining room", message: joinRoom.errorMessage ?? "")
    }
  }
  
  @IBAction func createNewRoomTapped(_ sender: Any) {
    let roomViewController = RoomViewController()
    //Sukuriu objekta, iskvieciu RoomManager funkcija
    let roomResult = roomManage.createRoom(parameter_roomName: roomIDTextField.text!)
    if let room = roomResult.room {
      roomViewController.property_room = room
      roomViewController.property_currentUser = user
      show(roomViewController, sender: nil)
    } else {
      showAlert(title: "Error creating room", message: roomResult.errorMessage ?? "")
    }
    
  }
  
  @IBAction func showOnlineUsersTapped(_ sender: UIButton) {
    showAlert(title: "Online Users:", message: "\(user.name)")
  }
  
  @IBAction func showOfflineUsersTapped(_ sender: UIButton) {
    showAlert(title: "Offline Users:")
  }
  
  @IBAction func logoutTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  func showAlert(title: String, message: String = "" ) {
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(alertAction)
    self.present(alertController, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "settings" {
      if let viewController = segue.destination as? SettingsViewController {
        viewController.user = user
      }
    }
  }
  
}

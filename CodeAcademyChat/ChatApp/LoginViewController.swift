//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var user: User!
    @IBOutlet weak var joinRoomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        welcomeLabel.text = "Hello, \(user.name.capitalized)!"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings" {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.user = user
            }
        }
    }
    
    @IBAction func joinRoomTapped(_ sender: Any) {
//        //Sukuriam Alert message
//        let alertController = UIAlertController(title: "Error Join The Room", message: "Room Not Found", preferredStyle: .alert)
//        //Sukuriam alert action
//        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        //Pridedame alert action
//        alertController.addAction(alertActionTwo)
//        alertController.addAction(alertAction)
//        self.present(alertController, animated: true)
        showAlert(title: "Error Joning Room", message: "Room Not Found!")
    }
    
    
    
    @IBAction func createNewRoomTapped(_ sender: Any) {
        showAlert(title: "Error Creating Room", message: "Room Name Can't be empty")
    }
    
    @IBAction func showOnlineUsersTapped(_ sender: Any) {
        showAlert(title: "Online Users:", message: user.name)
    }
    
    @IBAction func showOfflineUserTapped(_ sender: Any) {
        showAlert(title: "Offline Users:")
    }
    
    func showAlert(title: String, message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

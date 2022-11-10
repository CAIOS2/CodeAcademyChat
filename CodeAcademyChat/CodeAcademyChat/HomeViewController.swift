//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Dmitrij Aneicik on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var roomID: UITextField!
    
    
var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome \(user.username)"
    }
    
    @IBAction func joinRoomButton(_ sender: Any) {
        
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let alertController = UIAlertController(title: "Error joining room", message: "Room not found", preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func showOnlineUsersButton(_ sender: Any) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let alertController = UIAlertController(title: "These users are online:", message: "\(user.username)", preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
        
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
}

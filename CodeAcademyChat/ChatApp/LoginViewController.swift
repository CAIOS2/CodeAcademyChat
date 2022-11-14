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
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        welcomeLabel.text = "Hello, \(user.name.capitalized)!"
        
    }
    
    @IBAction func joinRoomTapped(_ sender: UIButton) {
        showAlert(title: "Error joining room", message: "Room not found")
    }
    
    
    @IBAction func createNewRoomTapped(_ sender: UIButton) {
        
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

//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-09.
//

import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var usernameLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        usernameLabel.text = user.username
    }
    
    @IBAction func userEditTapped(_ sender: Any) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { textField in textField.placeholder = "Username"
        }
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func passwordEditTapped(_ sender: Any) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        let alertController = UIAlertController(title: "Edit Password", message: "Enter your new password", preferredStyle: .alert)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { textField in textField.placeholder = "Password"
        }
        
        self.present(alertController, animated: true)
    }
}


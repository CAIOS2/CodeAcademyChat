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
        updateUI()
    }
    
    private func updateUI() {
        usernameLabel.text = user.username
    }
    
    @IBAction private func usernameEditTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let userName = alertController.textFields?.first?.text, userName.isEmpty  {
                self.user.username = userName
                self.updateUI()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Username"
        }
        
        self.present(alertController, animated: true)
    }
    
    
    @IBAction private func passwordEditTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Edit password", message: "Enter your new password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            let passwordTextField = alertController.textFields![0] as UITextField
            let confirmPasswordTextField = alertController.textFields![1] as UITextField
            
            if passwordTextField.text == confirmPasswordTextField.text {
                self.user.password = passwordTextField.text!
            } else {
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Password"
        }

        alertController.addTextField { textfield in
            textfield.placeholder = "Confirm password"
        }

        
        self.present(alertController, animated: true)
    }
}



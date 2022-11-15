//
//  SettingsViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameEdit: UIButton!
    @IBOutlet weak var passwordEdit: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        updateUsername()
    }
    
    private func updateUsername() {
        usernameLabel.text = user.name
    }
    
    @IBAction func usernameEditTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            if let userName = alertController.textFields?.first?.text {
                self.user.name = userName
                self.updateUsername()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Username"
        }
        self.present(alertController, animated: true)
    }
    
    @IBAction func passwordEditTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Edit password", message: "Enter your new password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            let passwordTextField = alertController.textFields![0] as UITextField
            let confirmpasswordTextField = alertController.textFields![1] as UITextField
            if passwordTextField.text == confirmpasswordTextField.text {
                self.user.password = passwordTextField.text!
                
            } else {
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Password"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Confirm Password"
        }
        self.present(alertController, animated: true)
    }
    
}


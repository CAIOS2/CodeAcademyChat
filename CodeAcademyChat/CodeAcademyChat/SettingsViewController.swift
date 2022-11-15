//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-09.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        usernameLabel.text = user.username
    }
    private func updateUI() {
        usernameLabel.text = user.username
    }
    
    @IBAction private func usernameEditTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Edit username", message: "Enter your new username", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            if let userName = alertController.textFields?.first?.text, userName.isEmpty {
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
    
    @IBAction func passwordEditTapped(_ sender: Any) {
        let textFieldPlaceholders = ["Password", "Confirm password"]
        let alertController = UIAlertController(title: "Enter password", message: "Enter your new password", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//            guard let textfields = alertController.textFields, textfields.count == textFieldPlaceholders.count
//            else {
//                return
//            }
            let passwordTextField = alertController.textFields![0] as UITextField
            let confirmPasswordTextField = alertController.textFields![1] as UITextField
            if passwordTextField.text == confirmPasswordTextField.text {
                self.user.password = passwordTextField.text!
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        textFieldPlaceholders.forEach { placeholder in
            alertController.addTextField { textfield in
                textfield.placeholder = placeholder
            }
        }
        self.present(alertController, animated: true)
//        alertController.addTextField { textField in
//            textField.placeholder = "Password"
//            alertController.addTextField { textField in
//                textField.placeholder = "Confirm password"
//                self.present(alertController, animated: true)
//            }
//
//
//
//        }
    }
}

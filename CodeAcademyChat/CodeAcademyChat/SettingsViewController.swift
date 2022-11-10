//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by Dmitrij Aneicik on 2022-11-09.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func editUsername(_ sender: Any) {
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let alertController = UIAlertController(title: "Edit username", message: "Enter your username", preferredStyle: .alert)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
    
        alertController.addTextField {text in
            
            text.placeholder = "username"
        }
        self.present(alertController, animated: true)
    }
    
    @IBAction func editPassword(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Change password", message: "Enter your password", preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Password"
        }

        alertController.addTextField { textfield in
            textfield.placeholder = "Confirm password"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            
            let passwordTextField = alertController.textFields![0] as UITextField
            let confirmPasswordTextField = alertController.textFields![1] as UITextField
            
            if passwordTextField.text == confirmPasswordTextField.text {
                //        self.user.password = passwordTextField.text!
                print("Good")
            } else {
                print("Bad")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}

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
        usernameLabel.text = user.name
    }
    
    @IBAction func editUserNameTapped(_ sender: Any) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter username"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
        
        
    }
    
    @IBAction func editPasswordTapped(_ sender: Any) {
        let textFieldsPlaceHolder = ["Password", "Confirm Password"]
        
        let alertController = UIAlertController(title: "Edit Password", message: "Enter your new password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textFields = alertController.textFields, textFields.count == textFieldsPlaceHolder.count
            else {
                return
            }
            
            let passwordTextField = alertController.textFields![0] as UITextField
            let confirmPasswordTextField = alertController.textFields![1] as UITextField
            
            if passwordTextField.text == confirmPasswordTextField.text {
                //Good
                self.user.name = passwordTextField.text!
            } else {
                
                //Bad
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        textFieldsPlaceHolder.forEach { placeholder in
            alertController.addTextField { textfield in
                textfield.placeholder = placeholder
                
            }
        }
        
        self.present(alertController, animated: true)
    }
    
}


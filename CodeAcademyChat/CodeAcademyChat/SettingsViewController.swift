//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-16.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func editUsernameButton(_ sender: Any) {
        showUserNameChangeAlert()
    }
    
    @IBAction func editPasswordButton(_ sender: Any) {
        showPasswordChangeAlert()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?
            .setNavigationBarHidden(false, animated: true)
    }
    
    func showUserNameChangeAlert() {
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            let usernameTextField = alertController.textFields![0] as UITextField
            if usernameTextField.text != nil {
                do {
                    try sharedDataManager.user?.changeUsername(username: usernameTextField.text!)
                    sharedDataManager.currentUsername = usernameTextField.text!
                } catch let e as NSError {
                    showAlert(title: "Error", e.domain)
                }
            } else {
                showAlert(title: "Alert", "Username is not changed")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Username"
        }
        
        self.present(alertController, animated: true)
    }
    
    func showPasswordChangeAlert() {
        let alertController = UIAlertController(title: "Edit Username", message: "Enter your new username", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            let oldPasswordTextField = alertController.textFields![0] as UITextField
            let newPasswordTextField = alertController.textFields![1] as UITextField
            let verifyNewPasswordTextField = alertController.textFields![2] as UITextField
            
            if oldPasswordTextField.text != nil && newPasswordTextField.text != nil && verifyNewPasswordTextField.text != nil {
                if newPasswordTextField.text! == verifyNewPasswordTextField.text! {
                    do {
                        try sharedDataManager.user?.changePassword(oldPassword: oldPasswordTextField.text!, newPassword: newPasswordTextField.text!)
                        showAlert(title: "Alert", "Password successfully changed")
                    } catch let e as NSError {
                        showAlert(title: "Error", e.domain)
                    }
                } else {
                    showAlert(title: "Alert", "Password is not changed")
                }

            } else {
                showAlert(title: "Alert", "Password is not changed")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Old Password"
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "New Password"
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Password Verification"
        }
        
        self.present(alertController, animated: true)
    }
    
    func showAlert(title: String, _ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

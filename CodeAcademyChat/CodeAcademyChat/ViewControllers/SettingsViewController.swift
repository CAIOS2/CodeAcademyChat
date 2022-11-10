//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class SettingsViewController: UIViewController {

    var loggedUserName: User!
   // var newPassword: String = ""
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameLabel.text = loggedUserName.username
    }


    @IBAction func usernameEditPerssed(_ sender: Any) {
      
        let alertController = UIAlertController(title: "Edit username:", message: "Your new username", preferredStyle: .alert)
        
        let alerActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let alerActionOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            
            guard let fields = alertController.textFields, fields.count == 1 else {
                return
            }
            let newUsernameField = fields[0]
            
            guard let newUsername = newUsernameField.text, !newUsername.isEmpty  else {
                return
            }
//            print("Your username: \(newUsername)")
            self.loggedUserName.username = newUsername
            self.usernameLabel.text = newUsername

            
            
        })
        

        
        alertController.addTextField{ field in
            field.placeholder = "New username"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alertController.addAction(alerActionOk)
        alertController.addAction(alerActionCancel)
        
        self.present(alertController, animated: true)
        
        
    }
    
    
    @IBAction func passwordEditTapped(_ sender: Any) {

        
        let alertController = UIAlertController(title: "Edit password:", message: "Your new password", preferredStyle: .alert)
        
        
        
        alertController.addTextField{ field in
            field.placeholder = "Password"
            field.returnKeyType = .next
            field.keyboardType = .default
            field.isSecureTextEntry  = true
        }
        alertController.addTextField{ field in
            field.placeholder = "Confirm password"
            field.returnKeyType = .next
            field.keyboardType = .default
            field.isSecureTextEntry  = true
        }
        

        
        let alerActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let alerActionOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            guard let fields = alertController.textFields, fields.count == 2 else {
                return
            }
            let newPasswordField = fields[0]
            let newConfirmPasswordField = fields[1]
            
            guard let password = newPasswordField.text, !password.isEmpty,
                  let confirmPassword = newConfirmPasswordField.text, !confirmPassword.isEmpty,
                  password == confirmPassword
            else {
                print("Something wrong with psw")
                return
            }
//            print(self.loggedUserName.password)
//            print("Your password: \(password), confirm password: \(confirmPassword)")
            self.loggedUserName.password = password
         //   print(self.loggedUserName.password)
            
        })
        
        alertController.addAction(alerActionOk)
        alertController.addAction(alerActionCancel)
        
        
        self.present(alertController, animated: true)
    }
    
    
    
    
}

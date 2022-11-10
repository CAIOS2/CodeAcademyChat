//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class SettingsViewController: UIViewController {

    var loggedUserName: User!
    
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
      
    
        
        let alerActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let alerActionOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        let alertController = UIAlertController(title: "Edit username:", message: "Your new username", preferredStyle: .alert)
        
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
        let alerActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
        let alerActionOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        let alertController = UIAlertController(title: "Edit password:", message: "Your new password", preferredStyle: .alert)
        
        alertController.addTextField{ field in
            field.placeholder = "Password"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        alertController.addTextField{ field in
            field.placeholder = "Confirm password"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alertController.addAction(alerActionOk)
        alertController.addAction(alerActionCancel)
        
        self.present(alertController, animated: true)
    }
    
    
    
    
}

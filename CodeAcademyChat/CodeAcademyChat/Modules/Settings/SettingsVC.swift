//
//  SettingsVC.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var usernameTextLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        updateUI()
    }
    
    private func updateUI(){
        usernameTextLabel.text = user.username
    }
    
    
    @IBAction func editUsername(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your new username", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Username"
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { confirm in
            guard let newName = alert.textFields?[0].text else {
                print("Enter username")
                return
            }
            self.user.username = newName
            self.updateUI()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        present(alert, animated: true)
    }
    
    
    @IBAction func editPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your new password", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "new password"
            //            textField.isSecureTextEntry = true
        }
        alert.addTextField { textField in
            textField.placeholder = "confirm new password"
            //            textField.isSecureTextEntry = true
            
        }
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            
            guard alert.textFields![0].text == alert.textFields![1].text else {
                print("password has not match")
                return
            }
            guard let newPassword = alert.textFields?[0].text else {
                return
            }
            self.user.password = newPassword
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

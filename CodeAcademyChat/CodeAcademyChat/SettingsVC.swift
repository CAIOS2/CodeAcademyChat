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
        usernameTextLabel.text = user.username


        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editUsername(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your new username", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { UIAlertAction in
//            self.user.username = "naujas vardas"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addTextField { textField in
            textField.placeholder = "new username"
        }
        present(alert, animated: true)
    }
    
    
    @IBAction func editPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your new password", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addTextField { textField in
            textField.placeholder = "new password"
        }
        alert.addTextField { textField in
            textField.placeholder = "confirm new password"
        }
        present(alert, animated: true)
    }
    

}

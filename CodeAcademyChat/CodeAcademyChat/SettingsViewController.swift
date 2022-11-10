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

        // Do any additional setup after loading the view.
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
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let alertController = UIAlertController(title: "Edit username", message: "Enter your username", preferredStyle: .alert)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
    
        alertController.addTextField {text in
            
            text.placeholder = "password"
        }
        
        alertController.addTextField {text in
            
            text.placeholder = "confirm password"
        }
        
        self.present(alertController, animated: true)
        
    }
}

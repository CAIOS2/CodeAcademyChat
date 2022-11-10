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
    }
    
    
    @IBAction func editPassword(_ sender: Any) {
    }
    

}

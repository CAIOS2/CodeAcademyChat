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
        
     //   if let username = loggedUserName.username {
        usernameLabel.text = loggedUserName.username
            
        
    }


}

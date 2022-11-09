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
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
        
    
    }


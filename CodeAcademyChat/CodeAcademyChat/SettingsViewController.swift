//
//  SettingsViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-09.
//

import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var usernameLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        usernameLabel.text = user.username
    }
    
}


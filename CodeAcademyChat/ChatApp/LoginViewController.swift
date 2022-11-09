//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        welcomeLabel.text? = "Hello, \(user.name.capitalized)!"
        
    }

 

}

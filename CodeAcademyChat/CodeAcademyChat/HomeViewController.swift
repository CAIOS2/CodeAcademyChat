//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Dmitrij Aneicik on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var roomID: UITextField!
    
var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome \(user.username)"
    }
    

}

//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var helloUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloUsername.text = "Hello, \(sharedDataManager.currentUsername!)"
    }

    @IBAction func logoutButton(_ sender: Any) {
        sharedDataManager.logout()
        self.dismiss(animated: true)
    }
    func setUserData(username: String) {
        
//        if let text = helloUsername.text {
//            helloUsername.text = text + username
//        }
    }
}

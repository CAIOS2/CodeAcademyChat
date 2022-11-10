//
//  MainViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class MainViewController: UIViewController {

    var loggedUserName: User!
    var userForSegue: User!
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = ""
        errorMessage.isHidden = true
        // Do any additional setup after loading the view.

            
        self.navigationItem.setHidesBackButton(false, animated: false)
      //  helloLabel.text = "Hello, \(loggedUserName)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helloLabel.text = "Hello, \(loggedUserName.username)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.loggedUserName = userForSegue
            }
        }
    }
    
    
    

    @IBAction func actionJoinRoom(_ sender: Any) {
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: "Error joining room", message: "Room not found", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    
    @IBAction func actionShowOnlineUsers(_ sender: Any) {
        
        let alerAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: "Online users:", message: "must_be_online_user_list", preferredStyle: .alert)
        
        alertController.addAction(alerAction)
        self.present(alertController, animated: true)
        
    }
    
    @IBAction func actionShowOfflineUsers(_ sender: Any) {
        let alerAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController(title: "Online users:", message: "must_be_offline_user_list", preferredStyle: .alert)
        
        alertController.addAction(alerAction)
        self.present(alertController, animated: true)
    }
    
    
    
    @IBAction func actionSettings(_ sender: Any) {
        userForSegue = loggedUserName
    }
    
}

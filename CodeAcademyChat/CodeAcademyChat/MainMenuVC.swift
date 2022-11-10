//
//  MainMenuVC.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import UIKit

class MainMenuVC: UIViewController {
    
    
    @IBOutlet weak var joinRoomButton: UIButton!
    @IBOutlet weak var createNewRoomButton: UIButton!
    @IBOutlet weak var showOnlineButton: UIButton!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var showOfflineButton: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinRoomButton.layer.cornerRadius = 10
        createNewRoomButton.layer.cornerRadius = 10
        showOnlineButton.layer.cornerRadius = 10
        showOfflineButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSettings" {
            if let viewController = segue.destination as? SettingsVC {
                viewController.user = user
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        greetingLabel.text = "Hello, \(user.username)"
    }

    
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
}

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
    @IBOutlet weak var showOfflineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinRoomButton.layer.cornerRadius = 10
        createNewRoomButton.layer.cornerRadius = 10
        showOnlineButton.layer.cornerRadius = 10
        showOfflineButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

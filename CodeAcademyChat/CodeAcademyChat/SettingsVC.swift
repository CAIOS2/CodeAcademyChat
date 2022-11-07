//
//  SettingsVC.swift
//  CodeAcademyChat
//
//  Created by Nikita Aleksejevas on 2022-11-07.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var messageHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageHistoryButton.layer.cornerRadius = 10

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

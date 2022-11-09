//
//  SettingsViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SettingsViewController {
                viewController.modalPresentationStyle = .fullScreen
                viewController.modalTransitionStyle = .flipHorizontal
            }
        
        
        
        
    }
}

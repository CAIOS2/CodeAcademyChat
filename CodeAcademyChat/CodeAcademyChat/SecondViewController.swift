//
//  SecondViewController.swift
//  CodeAcademyChat
//
//  Created by Andrius J on 2022-11-06.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var wlcomeMessage: UILabel!
    
    @IBOutlet
    weak var roomIdTextField: UITextField!
    
    @IBOutlet
    weak var settingsLabel: UILabel!
    
    @IBOutlet
    weak var greatingTextField: UITextField!
    
    
    var user: User!
    
    override func loadView() {
        super.viewDidLoad()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wlcomeMessage.text = "Welcome, \(user.username)"
    }
    
    
    
    @IBAction
    func joinRoomButton(_ sender: Any) {
        
    }
    @IBAction
    func creatRoomButton(_ sender: Any) {
        
    }
    @IBAction
    func showOnlineButton(_ sender: Any) {
        
    }
    
    @IBAction
    func showoflineButton(_ sender: Any) {
    }
    
    
    @IBAction
    func logoutButton(_ sender: Any) {
    }
    
    
    
   
}

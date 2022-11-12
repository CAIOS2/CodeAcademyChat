//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Deividas Zabulis on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
        
    
    var user: User!
        
        override func loadView() {
            super.loadView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()


            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = true
            userLabel.text = "Welcome, \(user.username)"
        }
    
    @IBAction private func joinRoomTapped(_ sender: Any) {
showAlert(title: "Error joining room", message: "Room not found")
    }
    @IBAction private func newRoomTapped(_ sender: Any) {
        let roomViewController = RoomViewController()
                navigationController?.present(roomViewController, animated: true)
        showAlert(title: "Error creating room", message: "Room name can't be empty!")
    }
    @IBAction private func onlineUsersTapped(_ sender: Any) {
        showAlert(title: "Online users:", message: "\(user.username)")
    }
    @IBAction private func offlineUsersTapped(_ sender: Any) {
        showAlert(title: "Offline users:", message: "")
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    private func showAlert(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.user = user
            }
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

//
//  HomeViewController.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        welcomeLabel.text = "Hello, \(user.username)"
    }
    
    @IBAction private func joinRoomTapped(_ sender: Any) {
        showAlert(title: "Error joining room", message: "Room not found")
    }
    
    @IBAction private func createNewRoomTapped(_ sender: Any) {
        showAlert(title: "Error creating room", message: "Room name can't be empty!")
    }
    
    @IBAction private func showOnlineUserTapped(_ sender: Any) {
        showAlert(title: "Online users:", message: "\(user.username)")
    }
    
    @IBAction private func showOfflineUserTapped(_ sender: Any) {
        showAlert(title: "Offline users:")
    }
    
    @IBAction private func logoutTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String = "") {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SettingsViewController {
            viewController.user = user
        }
    }
}

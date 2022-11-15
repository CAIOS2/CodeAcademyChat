//
//  ViewController.swift
//  ChatApp
//
//  Created by Linas Nutautas on 09/11/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    enum State {
        case register
        case login
    }
    
    var currentState: State = .register
    let userManager: UserManager = UserManager()
    var userForSegue: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func onSegmentChange(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            currentState = .register
        } else if segmentedControl.selectedSegmentIndex == 1 {
            currentState = .login
        }
        confirmPasswordTextField.isHidden = currentState != .register
        
        switch currentState {
        case .register:
            actionButton.setTitle("Register", for: .normal)
        case .login:
            actionButton.setTitle("Login", for: .normal)
        }
    }
    
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        switch currentState {
        case .register:
            let result = userManager.registration(
                parameter_username: usernameTextField.text!,
                parameter_password: passwordTextField.text!,
                parameter_confirmPassword: confirmPasswordTextField.text!)
                validateUser(from: result)
        case .login:
            let result = userManager.login(username: usernameTextField.text!, password: passwordTextField.text!)
                validateUser(from: result)
        }
    }
    
    func validateUser(from userResult: UserResult) {
        if let errorTitle = userResult.errorTitle, let errorMessage = userResult.errorMessage {
            showError(title: errorTitle, message: errorMessage)
        } else {
            if let user = userResult.user {
                userForSegue = user
                performSegue(withIdentifier: "loginView", sender: nil)
            }
        }
    }
    func showError(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginView" {
            if let viewController = segue.destination as? LoginViewController {
                viewController.user = userForSegue
                userForSegue = nil
            }
        }
    }
}

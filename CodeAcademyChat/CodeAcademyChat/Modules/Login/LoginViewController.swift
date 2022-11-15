//
//  ViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-03.
//

import UIKit

class LoginViewController: UIViewController {
    enum State {
        case register
        case login
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
//    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var currentState: State = .register
    
    let userManager: UserManager = UserManager()
    var userForSegue: User!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            actionButton.titleLabel?.text = "Register"
        case .login:
            actionButton.titleLabel?.text = "Login"
        }
    }

    
    @IBAction func onActionButtonClick(_ sender: Any) {
        switch currentState {
        case .register:
            
            let result = userManager.register(
                username: usernameTextField.text!,
                password: passwordTextField.text!,
                confirmPassword: confirmPasswordTextField.text!)
            validateUser(from: result)
        case .login:
            let result = userManager.login(username: usernameTextField.text!, password: passwordTextField.text!)
            validateUser(from: result)
        }
    }
    
    private func validateUser(from userResult: UserResult) {
        if let errorMessage = userResult.errorMessage {
            showError(message: errorMessage)

//            errorMessageLabel.text = errorMessage
//            errorMessageLabel.isHidden = false
        }else {
//            errorMessageLabel.isHidden = true
            if let user = userResult.user {
                userForSegue = user
                performSegue(withIdentifier: "home", sender: nil)
            }
        }
    }
    private func showError(message: String) {
        let title = "Error logging in"
        let alertAction = UIAlertAction(title: "OK", style: .default)
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if let viewController = segue.destination as? HomeViewController {
//                viewController.modalTransitionStyle = .flipHorizontal
//                viewController.modalPresentationStyle = .fullScreen
                viewController.user = userForSegue
                userForSegue = nil
            }
        }
    }
}

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
    @IBOutlet weak var errorMessageLabel: UILabel!
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
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? LoginViewController {
            
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .flipHorizontal
            viewController.user = userForSegue
            userForSegue = nil
        }
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
                username: usernameTextField.text!,
                password: passwordTextField.text!,
                confirmPassword: confirmPasswordTextField.text!)
            if let errorMessage = result.errorMessage {
                errorMessageLabel.text = errorMessage
                errorMessageLabel.isHidden = false
            } else {
                errorMessageLabel.isHidden = true
            }
        case .login:
            let result = userManager.login(username: usernameTextField.text!, password: passwordTextField.text!)
            if let errorMessage = result.errorMessage {
                errorMessageLabel.text = errorMessage
                errorMessageLabel.isHidden = false
            } else {
                errorMessageLabel.isHidden = true
                if let user = result.user {
                    userForSegue = user
                    performSegue(withIdentifier: "login", sender: self)
                }
                
            }
            
        }
    }
}

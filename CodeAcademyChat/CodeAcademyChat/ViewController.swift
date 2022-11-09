//
//  ViewController.swift
//  CodeAcademyChat
//
//  Created by Romas Petkus on 2022-11-07.
//

import UIKit

class ViewController: UIViewController {
    enum State {
        case register
        case login
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var userForSegue:User?
    
    var currentState: State = .register
    
    let userManager: UserManager = UserManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            
            if let homeVC = segue.destination as? HomeViewController {
                
                homeVC.user = userForSegue
            }
        }
    }
    
    @IBAction func onSegmentChange(_ sender: Any) {
        
        usernameTextField.text = ""
        passwordTextField.text = ""
        
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
    
    @IBAction func onActionButtonClick(_ sender: Any) {
        switch currentState {
        case .register:
            
            let result = userManager.register(
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
            
            let result = userManager.login(
                username: usernameTextField.text!,
                password: passwordTextField.text!)
            if let errorMessage = result.errorMessage {
                errorMessageLabel.text = errorMessage
                errorMessageLabel.isHidden = false
            } else {
                errorMessageLabel.isHidden = true
                
                userForSegue = result.user
                performSegue(withIdentifier: "home", sender: nil)
            }
        }
    }
}


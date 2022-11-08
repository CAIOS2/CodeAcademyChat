//
//  ViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-03.
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
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var currentState: State = .register
    let users: UserManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSegmentChange(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            currentState = .register
        } else if segmentControl.selectedSegmentIndex == 1 {
            currentState = .login
        }
        
        confirmPasswordTextField.isHidden = currentState != .register
        
        switch currentState {
        case .register:
            registerButton.titleLabel?.text = "Registration"
        case .login:
            registerButton.titleLabel?.text = "Login"
            
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        switch currentState {
        case .register:
            let result = users.register(
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
            let login = users.login(username: usernameTextField.text!, password:passwordTextField.text!)
            
            if login.isLogin != nil {
                performSegue(withIdentifier: "toMainMenu", sender: self)
            } else {
                errorMessageLabel.text = login.errorMessage
                errorMessageLabel.isHidden = false
            }
            
        }
    }
}
        



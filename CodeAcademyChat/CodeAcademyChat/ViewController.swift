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
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var errorMessageTextField: UITextField!
    var currentState: State = .register
    
    var userManager: UserManager = UserManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//    }
//    @IBAction func buttonClick(_ sender: Any) {
//
//        userManager.register(username: userNameTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
    }
    
    @IBAction func onSegment(_ sender: Any) {
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
                username: userNameTextField.text!,
                password: passwordTextField.text!,
                confirmPassword: confirmPasswordTextField.text!)
            if let errorMessage = result.errorMessage {
                errorMessageTextField.text = errorMessage
                errorMessageTextField.isHidden = false
            } else {
                errorMessageTextField.isHidden = true
            }
        case .login:
            break
            
        }
        
    }
}



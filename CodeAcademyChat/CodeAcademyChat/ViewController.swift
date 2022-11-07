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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    var currentState: State = .register
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        userManager.registration(username: usernameTextField.text!, password: passwordTextField.text!, comfirmPasword: confirmPasswordTextField.text!)
        
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
    
}


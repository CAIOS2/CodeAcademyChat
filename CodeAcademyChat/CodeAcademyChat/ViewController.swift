//
//  ViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-03.
//

import UIKit

class ViewController: UIViewController {
    
    let userManager: UserManager = UserManager()
    enum State {
        case register
        case login
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    
    var currentState: State = .login
    
    //    var users: [User]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        
        userManager.register(username: usernameTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
    }
    @IBAction func onSegmentChange(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            currentState = .register
        } else if segmentedControl.selectedSegmentIndex == 1 {
            currentState = .login
        }
        
        confirmPasswordTextField.isHidden = currentState != .register
        //        confirmPasswordTextField.isHidden = segmentedControl.selectedSegmentIndex != 0
        switch currentState {
        case .register:
            actionButton.titleLabel?.text = "Register"
        case .login:
            actionButton.titleLabel?.text = "Login"
        }
        
    }
}

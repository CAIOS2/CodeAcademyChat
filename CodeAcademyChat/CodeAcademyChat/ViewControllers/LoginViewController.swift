//
//  LoginViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class LoginViewController: UIViewController {

    var userManager = UserManager()
    
    enum State {
        case register
        case login
    }
    
    var currentState: State = .register
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSegemntChange(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            currentState = .register
            actionButton.titleLabel?.text = "Register"
       //     confirmPasswordTextField.isHidden = false
        } else {
            currentState = .login
       //     confirmPasswordTextField.isHidden = true
            actionButton.titleLabel?.text = "Login"
        }
        confirmPasswordTextField.isHidden = currentState != .register
    }
    
    
    @IBAction func actionButtonIsPressed(_ sender: Any) {
        
        if currentState == .register {
            userManager.addNewUser(username: usernameTextField.text ?? "",
                                   password: passwordTextField.text ?? "",
                                   confirmPassword: confirmPasswordTextField.text ?? "")
            
//            print(userManager.userList)
            
        }
        
    }
    
    
    
}

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
    
    var currentState: State = .register
        
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
    
}


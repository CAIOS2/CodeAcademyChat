//
//  AppEntryViewController.swift
//  CodeAcademyChat
//
//  Created by nonamekk on 2022-11-05.
//

import UIKit

class AppEntryViewController: UIViewController {
    
    // true is Registration, false is Login
    @IBOutlet weak var entrySegments: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!

    var segmentTitleIsRegistration: Bool = true
    
    @IBAction func segmentedEntryChange(_ sender: Any) {
        segmentTransition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let userData = UserData()
        if !(usernameTextField.text?.isEmpty ?? false) && !(passwordTextField.text?.isEmpty ?? false) {
            if segmentTitleIsRegistration {
                if !(passwordConfirmationTextField.text?.isEmpty ?? false) {
                    if passwordTextField.text == passwordConfirmationTextField.text {
                        if let username = userData.addUser(username: usernameTextField.text!, password: passwordTextField.text!) {
                            print(username)
                        } else {
                            print("user already registered")
                        }
                    }
                }
            } else {
                if let username = userData.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) {
                    print(username)
                } else {
                    print("wrong password or no user")
                }
            }
        }
    }
    
    func segmentTransition() {
        if segmentTitleIsRegistration {
            passwordConfirmationTextField.isHidden = true
            submitButton.setTitle("Login", for: .normal)
            segmentTitleIsRegistration = false
        } else {
            passwordConfirmationTextField.isHidden = false
            submitButton.setTitle("Registration", for: .normal)
            segmentTitleIsRegistration = true
        }
    }
}

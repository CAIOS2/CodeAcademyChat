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

    @IBOutlet weak var errorMessage: UILabel!
    var segmentTitleIsRegistration: Bool = true
    
    @IBAction func segmentedEntryChange(_ sender: Any) {
        segmentTransition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func switchToHomeView(username: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.setUserData(username: username)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
//        let userData = UserData()
//        if (usernameTextField.text?.isEmpty ?? false) {
//            errorMessage.text = "No username"
//            errorMessage.isHidden = false
//            return
//        }
//        if (passwordTextField.text?.isEmpty ?? false) {
//            errorMessage.text = "No password"
//            errorMessage.isHidden = false
//            return
//        }
//        
//        if segmentTitleIsRegistration {
//            if !(passwordConfirmationTextField.text?.isEmpty ?? false) {
//                if passwordTextField.text == passwordConfirmationTextField.text {
//                    if let username = userData.addUser(username: usernameTextField.text!, password: passwordTextField.text!) {
//                        switchToHomeView(username: username)
//                        errorMessage.isHidden = true
//                    } else {
//                        errorMessage.text = "Username already exists"
//                        errorMessage.isHidden = false
//                    }
//                } else {
//                    errorMessage.text = "Passwords don't match"
//                    errorMessage.isHidden = false
//                }
//            } else {
//                errorMessage.text = "No password confirmation"
//                errorMessage.isHidden = false
//            }
//        } else {
//            if let username = userData.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) {
//                switchToHomeView(username: username)
//                errorMessage.isHidden = true
//            } else {
//                errorMessage.text = "Wrong password"
//                errorMessage.isHidden = false
//            }
//        }
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

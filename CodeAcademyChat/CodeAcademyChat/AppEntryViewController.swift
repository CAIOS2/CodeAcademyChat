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
    
    override func viewWillAppear(_ animated: Bool) {
        if sharedDataManager.getLoginFromSavedData() {
            switchToHomeView()
        }
    }
    
    func switchToHomeView() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        performSegue(withIdentifier: "home", sender: nil)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if (usernameTextField.text?.isEmpty ?? false) {
            showError("No username")
            return
        }
        if (passwordTextField.text?.isEmpty ?? false) {
            showError("No password")
            return
        }
        
        if segmentTitleIsRegistration {
            if !(passwordConfirmationTextField.text?.isEmpty ?? false) {
                if passwordTextField.text == passwordConfirmationTextField.text {
                    do {
                        try sharedDataManager.createUser(username: usernameTextField.text!, password: passwordTextField.text!)
                            switchToHomeView()
                    } catch let e as NSError {
                        showError(e.domain)
                    }
                } else {
                    showError("Passwords don't much")
                }
            } else {
                showError("No confirmation of password")
            }
        } else {
            do {
                // will only obtain true if success
                try sharedDataManager.login(username: usernameTextField.text!, password: passwordTextField.text!)
                switchToHomeView()
                
            } catch let e as NSError {
                showError(e.domain)
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
    
    func showError(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

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
    var userForSegue: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        //    }
        //    @IBAction func buttonClick(_ sender: Any) {
        //
        //        userManager.register(username: userNameTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if let viewController = segue.destination as? SecondViewController {
                viewController.user = userForSegue
                userForSegue = nil
            }
            
        }
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
            
            let result = userManager.login(username: userNameTextField.text!, password: passwordTextField.text!)
            
            if let errorMessage = result.errorMessage {
                errorMessageTextField.text = errorMessage
                errorMessageTextField.isHidden = false
            } else {
                errorMessageTextField.isHidden = true
                if let user = result.user {
                    userForSegue = user
                    performSegue(withIdentifier: "home", sender: nil)
                }
            }
            break
        }
        
    }
}
        
        //            let login = userManager.login(username: userNameTextField.text!, password:passwordTextField.text!)
        //
        //            if login.isLogin != nil {
        //                performSegue(withIdentifier: "Go to menu", sender: self)
        //            } else {
        //                errorMessageTextField.text = login.errorMessageTextField
        //                errorMessageTextField.isHidden = false
        
        
  

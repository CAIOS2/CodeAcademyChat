//
//  ViewController.swift
//  CodeAcademyChat
//
//  Created by Tadas Petrikas on 2022-11-03.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    var userForSegue: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainMenu" {
            if let viewController = segue.destination as? MainMenuVC {
                viewController.user = userForSegue
                userForSegue = nil
                
            }
        }
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
            registerButton.setTitle("Registration", for: .normal)
        case .login:
            registerButton.setTitle("Login", for: .normal)
            
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
//            let login = users.login(username: usernameTextField.text!, password:passwordTextField.text!)
//            nameText = usernameTextField.text!
//            if login.isLogin != nil {
//                performSegue(withIdentifier: "toMainMenu", sender: self)
//            } else {
//                errorMessageLabel.text = login.errorMessage
//                errorMessageLabel.isHidden = false
//            }
            let result = users.login(username: usernameTextField.text!, password: passwordTextField.text!)
            if let errorMessage = result.errorMessage {
                let alert = UIAlertController(title: "Attention", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
                errorMessageLabel.text = errorMessage
                errorMessageLabel.isHidden = false
            } else {
                errorMessageLabel.isHidden = true
                if let user = result.user{
                    userForSegue = user
                    performSegue(withIdentifier: "toMainMenu", sender: self)
                }
            }
        }
    }
}

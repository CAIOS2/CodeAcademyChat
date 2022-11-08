//
//  LoginViewController.swift
//  CodeAcademyChat
//
//  Created by GK on 2022-11-06.
//

import UIKit

class LoginViewController: UIViewController {

    var userManager = UserManager()
    var openMainVC: Bool = true
    
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
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        errorMessage.isHidden = true
        errorMessage.text = ""
        passwordTextField.textContentType = .oneTimeCode
        confirmPasswordTextField.textContentType = .oneTimeCode
        actionButton.setTitle("Register", for: .normal)
    }
    

    func changeActionButtonLabel() {
        if segmentControl.selectedSegmentIndex == 0 {
            currentState = .register
            actionButton.setTitle("Register", for: .normal)
       //     confirmPasswordTextField.isHidden = false
        } else {
            currentState = .login
       //     confirmPasswordTextField.isHidden = true
            actionButton.setTitle("Login", for: .normal)
        }
    }
    
    
    @IBAction func onSegemntChange(_ sender: Any) {
        changeActionButtonLabel()
        confirmPasswordTextField.isHidden = currentState != .register
        userManager.getUserList()
    }
    
    
    @IBAction func actionButtonIsPressed(_ sender: Any) {
        
//        print(currentState)
        
        
        switch currentState {
            
        case .register:
            if let errMsg = userManager.addNewUser(
                                    username: usernameTextField.text ?? "",
                                    password: passwordTextField.text ?? "",
                                    confirmPassword: confirmPasswordTextField.text ?? "") {
                errorMessage.text       = errMsg
                errorMessage.isHidden   = false
                openMainVC              = false     //blokuoja sekancio lango atidaryma
                changeActionButtonLabel()

            } else {
                errorMessage.text       = ""
                errorMessage.isHidden   = true
                openMainVC              = true
                changeActionButtonLabel()

            }
            changeActionButtonLabel()
            
        case .login:
            
//            print(userManager.userLogin(
//                username: usernameTextField.text ?? "",
//                password: passwordTextField.text ?? ""))
            
            
            if userManager.userLogin(
                username: usernameTextField.text ?? "",
                password: passwordTextField.text ?? "") == true  {
                
                openMainVC              = true
            } else {
                errorMessage.text       = "User can't login"
                errorMessage.isHidden   = false
                openMainVC              = false
            }
            changeActionButtonLabel()
        }

        userManager.getUserList()
        
    }
    
    
    
    
    
    
    
     // skirta pagauti ir mygtukui savarankiskai neleisti atidaryti sekancios formos
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "goToMainViewController" {
                if openMainVC == false {
                    return false
                }
            }
        }
        // ir iskart atstatome pradine login busena
        errorMessage.isHidden = true
        errorMessage.text = ""
        return true
    }
    
    
}

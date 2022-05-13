//
//  ViewController.swift
//  improveTask1
//
//  Created by 1234 on 15.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: StyledButton!
    @IBOutlet var registrationButton: StyledButton!
    let keychain = KeychainSwift()
        
    @IBAction func loginAction(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else {
            return
        }
        
        let loginAnswer = AuthorizationMockSimulator().logIn(login: login, password: password)
        if loginAnswer.result == false{
            passwordTextField.shake()
            loginTextField.shake()
        }
                
        if loginAnswer.result == true,
           let autorizationToken = loginAnswer.token {
            keychain.set(autorizationToken, forKey: UserAutorizationConstants.keychainTokenKey)
            
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destinationViewController = mainStoryBoard.instantiateViewController(identifier: String(describing: UITabBarController.self))
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func registrationAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationViewController = mainStoryBoard.instantiateViewController(identifier:String(describing: RegisrationViewController().theClassName) )
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.returnKeyType = .continue
        passwordTextField.returnKeyType = .done
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        addTapGestureToHideKeyboard()
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}


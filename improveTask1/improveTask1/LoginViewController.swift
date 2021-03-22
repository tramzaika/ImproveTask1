//
//  ViewController.swift
//  improveTask1
//
//  Created by 1234 on 15.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
 
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var loginTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
 
    @IBOutlet var enterBtn: StyledButton!
    @IBOutlet var registrationBtn: StyledButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.returnKeyType = .continue
        passwordTF.returnKeyType = .done
        
        loginTF.delegate = self
        passwordTF.delegate = self
        
        addTapGestureToHideKeyboard()
    }
    
    func addTapGestureToHideKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
            view.addGestureRecognizer(tapGesture)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == loginTF {
            passwordTF.becomeFirstResponder()
        }else {
            passwordTF.resignFirstResponder()
        }
            return true
    }
}

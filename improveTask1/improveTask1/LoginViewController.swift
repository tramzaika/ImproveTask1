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
        
        
        
        //clojure
//        ["1","4","12","6"].first { [weak self] (stringElement) -> Bool in
//            guard let self = self else {return false}
//            let bool = self.filter(string: stringElement)
//            return bool
//            //вернет опциональную стрингу
//        }
//
//
//        let mapped = ["1","4","12","6"].map({
//            $0 + "_2"
//
//
//        })
//        print(mapped)
//    }
//
//    func  filter (string: String) -> Bool {
//        //return string
//    }
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

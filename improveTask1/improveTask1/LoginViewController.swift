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
    
    @IBOutlet var enterBtn: UIButton!
    @IBOutlet var registrationBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.alpha = 0.5
      //  view.backgroundColor.op
        loginTF.layer.cornerRadius = 10
        loginTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.56)
        loginTF.layer.borderWidth = 2
        
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.56)
        passwordTF.layer.borderWidth = 2
        
        enterBtn.addTarget(nil, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        loginTF.delegate = self
        
        // скрываем клавиатуру
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAction(sender:)))
        view.addGestureRecognizer(tap)
        
//        
//        switch tap.state {
//        
//        case .possible:
//            <#code#>
//        case .began:
//            <#code#>
//        case .changed:
//            <#code#>
//        case .ended:
//            <#code#>
//        case .cancelled:
//            <#code#>
//        case .failed:
//            <#code#>
//        @unknown default:
//            <#code#>
//        }
        
        //enterBtn.setTitle("111", for: .normal)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
    }

    
    @objc func buttonAction(sender: Any){
        if let tapSender = sender as?  UITapGestureRecognizer {
            switch tapSender.state {
           

            case .possible:
                break
            case .began:
                break
            case .changed:
                break
            case .ended:
                break
            case .cancelled:
                break
            case .failed:
                break
            @unknown default:
                break
            }
        }
        loginTF.becomeFirstResponder()
    }
    @IBAction func buttonAction2(_ sender: Any) {
        print("222")
    }
    
    
}
extension LoginViewController: UITextFieldDelegate {
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string != "1"
    }
    
    func  textFieldDidBeginEditing(_ textField: UITextField) {
      print("ewewewewewew")
    }
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.resignFirstResponder()
        return true
}


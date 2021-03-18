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
        
        view.alpha = 0.5
        loginTF.layer.cornerRadius = 10
        loginTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.56)
        loginTF.layer.borderWidth = 2
        
        passwordTF.layer.cornerRadius = 10
        passwordTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.56)
        passwordTF.layer.borderWidth = 2
        
       
       // view.backgroundColor = .black
       // titleLabel.backgroundColor = .red
       // titleLabel.text = "Sorry"
       // print(titleLabel.frame)
      //  print(titleLabel.bounds)
      
    }


}


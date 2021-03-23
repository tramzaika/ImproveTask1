//
//  RegistrationVC.swift
//  improveTask1
//
//  Created by 1234 on 22.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation
import  UIKit

class RegisrationViewController: UIViewController {
    
    @IBOutlet var scrollViewPic: UIScrollView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardVillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardVillShow(sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var insets = scrollViewPic.contentInset
            insets.bottom = keyboardSize.height
            scrollViewPic.contentInset = insets
        }
    }
    
    @objc func keyboardWillHide() {
        scrollViewPic.contentInset = .zero
    }
    
    func addTapGestureToHideKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
            view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

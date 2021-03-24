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
        
    @IBOutlet var registrationLabel: UILabel!
    
    @IBOutlet var loginRegTF: StyledTextField!
    @IBOutlet var passwordRegTF: StyledTextField!
    @IBOutlet var passwordRepeatRegTF: StyledTextField!
    
    @IBOutlet var doneBtn: StyledButton!
    
    @IBOutlet var scrollViewRegistrationVC: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardVillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loginRegTF.returnKeyType = .continue
        passwordRegTF.returnKeyType = .continue
        passwordRepeatRegTF.returnKeyType = .done
        
        loginRegTF.delegate = self
        passwordRegTF.delegate = self
        passwordRepeatRegTF.delegate = self
        scrollViewRegistrationVC.delegate = self
    }
    
    @objc func keyboardVillShow(sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var insets = scrollViewRegistrationVC.contentInset
            let height = scrollViewRegistrationVC.contentSize.height
            insets.top = (height - keyboardSize.height)/2
            insets.bottom = (height + keyboardSize.height)/2
            scrollViewRegistrationVC.contentInset = insets
        }
        if let animationTime = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            print(animationTime)
        }
    }
    
    @objc func keyboardWillHide() {
        scrollViewRegistrationVC.contentInset = .zero
    }
    
    func addTapGestureToHideKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
            view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RegisrationViewController: UITextFieldDelegate, UIScrollViewDelegate {
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginRegTF {
            passwordRegTF.becomeFirstResponder()
        }
        if textField == passwordRegTF{
        passwordRepeatRegTF.becomeFirstResponder()
        }else {
            passwordRepeatRegTF.resignFirstResponder()
        }
            return true
    }
    
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
           let scale = CGAffineTransform(scaleX: 1, y: 1)
           registrationLabel.transform = scale
           UIView.animate(withDuration: 1) {
                let scale = CGAffineTransform(scaleX: 1 + translation.y, y: 1 + translation.y)
                self.registrationLabel.transform = scale
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        registrationLabel.font = registrationLabel.font.withSize(36)
    }
}

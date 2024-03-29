//
//  RegistrationVC.swift
//  improveTask1
//
//  Created by 1234 on 22.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation
import  UIKit
import KeychainSwift

class RegisrationViewController: UIViewController{
    
    @IBOutlet var registrationLabel: UILabel!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var doneButton: StyledButton!
    @IBOutlet var scrollViewRegistrationViewController: UIScrollView!
    let keychain = KeychainSwift()
    
    @IBAction func registrationAction(_ sender: Any) {
        if textFields[1].text != textFields[2].text {
            textFields[2].shake()
        }
        guard let login = textFields[0].text,
              let password = textFields[1].text,
              let passwordRepeat = textFields[2].text,
              password == passwordRepeat
        else {
            return
        }
        
        let logInAnswer = AuthorizationMockSimulator().registerUser(login: login, password: password)
        if logInAnswer.result == true,
           let autorizationToken = logInAnswer.token {
            keychain.set(autorizationToken, forKey: UserAutorizationConstants.keychainTokenKey)
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destinationViewController = mainStoryBoard.instantiateViewController(identifier: String(describing: UITabBarController.self))
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textFields[0].returnKeyType = .continue
        textFields[1].returnKeyType = .continue
        textFields[2].returnKeyType = .done
        
        for textField in textFields {
            textField.delegate = self
        }
        scrollViewRegistrationViewController.delegate = self
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var insets = scrollViewRegistrationViewController.contentInset
            let height = scrollViewRegistrationViewController.contentSize.height
            insets.top = (height - keyboardSize.height)/2
            insets.bottom = (height + keyboardSize.height)/2
            scrollViewRegistrationViewController.contentInset = insets
        }
        if let animationTime = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            print(animationTime)
        }
    }
    
    @objc func keyboardWillHide() {
        scrollViewRegistrationViewController.contentInset = .zero
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
        textFields = textFields.sorted{ $0.frame.origin.y < $1.frame.origin.y }
        
        guard let indexTextField = textFields.firstIndex(of: textField) else {
            return false
        }
        
        if indexTextField+1 < textFields.count {
            textFields[indexTextField+1].becomeFirstResponder()
        }
        
        if textFields[indexTextField].returnKeyType == .done {
            textFields[indexTextField].resignFirstResponder()
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

extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10.0, y: self.center.y))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10.0, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}

//
//  StyledTextField.swift
//  improveTask1
//
//  Created by 1234 on 18.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//


import UIKit

@IBDesignable
class StyledTextField: UITextField {
    
    @IBInspectable var insetX: CGFloat = 0.0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        self.setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
    }
    
    private func setView() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.56)
        self.layer.borderWidth = 2
        self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
    
    //placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: 0.0)
    }
    
    //text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: 0.0)
    }
}

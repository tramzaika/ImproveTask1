//
//  StyledButton.swift
//  improveTask1
//
//  Created by 1234 on 21.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//


import UIKit

class StyledButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override open var isHighlighted: Bool {
        didSet {
          backgroundColor = isHighlighted ? UIColor.black : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
    }   
}

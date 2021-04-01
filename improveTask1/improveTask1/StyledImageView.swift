//
//  StyledImageView.swift
//  improveTask1
//
//  Created by 1234 on 31.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

class StyledImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

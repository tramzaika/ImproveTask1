//
//  UICollectionViewCell+Nibname.swift
//  improveTask1
//
//  Created by 1234 on 29.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static func nibName() -> String {
           String(describing: Self.self)
       }
}

//
//  UITableViewCell + NibName.swift
//  improveTask1
//
//  Created by 1234 on 05.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static func nibName() -> String {
           String(describing: Self.self)
       }
}

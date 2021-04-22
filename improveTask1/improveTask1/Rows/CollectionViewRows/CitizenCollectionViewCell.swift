//
//  CollectionViewCell.swift
//  improveTask1
//
//  Created by 1234 on 29.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

class CitizenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var activityView: UIView!
    
    var dataIdentifier = String()
}

//
//  CollectoinViewController.swift
//  improveTask1
//
//  Created by 1234 on 29.03.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

class CollectoinViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: CollectionViewCell.nibName(), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.nibName())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        }
    }

extension CollectoinViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let sideSize = screenBounds.width/2.0 - 10
        return CGSize(width: sideSize, height: sideSize)
    }
}

extension CollectoinViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.nibName(), for: indexPath) as? CollectionViewCell
        guard let collectionViewCell = cell
            else{
                return UICollectionViewCell()
        }
        collectionViewCell.cellImage.image = UIImage(named: "SpBob")
        collectionViewCell.cellLabel.text = "\(indexPath.row) from \(indexPath.section)"
        return collectionViewCell
    }
}

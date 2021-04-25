//
//  PlanetDetail.swift
//  improveTask1
//
//  Created by 1234 on 12.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import UIKit

class CitizenDetailViewController: UIViewController {
    var urlStringlist : [String]?
    var planetTitle = String()
    let personCreateService = CitizenCreateService()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        let CitizenCollectionViewCellNib = UINib(nibName: CitizenCollectionViewCell.nibName(), bundle: nil)
        collectionView.register(CitizenCollectionViewCellNib, forCellWithReuseIdentifier: CitizenCollectionViewCell.nibName())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        personCreateService.initiateModel()
        navigationItem.title = planetTitle
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 26.0
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CitizenDetailViewController: UICollectionViewDelegate {
   
}

extension CitizenDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellCount = urlStringlist?.count else {
            return 0
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CitizenCollectionViewCell.nibName(), for: indexPath) as? CitizenCollectionViewCell
        guard let collectionViewCell = cell
        else{
            return UICollectionViewCell()
        }
        if indexPath.row >= 200 {
            for i in 0...200{
                citizenDataCache.dictionaryOfCitizen.removeValue(forKey: citizenDataCache.urlArray[i])
            }
        }
        cell?.dataIdentifier = citizenDataCache.urlArray[indexPath.row]
        collectionViewCell.cellImage.layer.cornerRadius = 10
        collectionViewCell.layer.cornerRadius = 10
        collectionViewCell.activityIndicator.startAnimating()
        collectionViewCell.activityIndicator.hidesWhenStopped = true
        let url = citizenDataCache.urlArray[indexPath.row]
        
        if citizenDataCache.dictionaryOfCitizen[citizenDataCache.urlArray[indexPath.row]]?.name.count == 0{
        personCreateService.createOne(index: indexPath.row, completion: {  dictionary in
            guard let people = dictionary[url] else {return}
            DispatchQueue.main.async {
                if cell?.dataIdentifier == url{
                    collectionViewCell.nameLabel.text = people.name
                    collectionViewCell.genderLabel.text = people.gender
                    collectionViewCell.speciesLabel.text = people.species
                }
            }
        }, imageCompletion: {  dictionary in
            guard let people = dictionary[url] else {return}
            DispatchQueue.main.async {
                if cell?.dataIdentifier == url{
                    collectionViewCell.cellImage.image = people.previewImage
                    collectionViewCell.activityView.isHidden = true
                    collectionViewCell.activityIndicator.stopAnimating()
                }
            }
        })
        } else {
            guard let people = citizenDataCache.dictionaryOfCitizen[citizenDataCache.urlArray[indexPath.row]] else {return collectionViewCell}
            if cell?.dataIdentifier == url{
            collectionViewCell.nameLabel.text = people.name
            collectionViewCell.genderLabel.text = people.gender
            collectionViewCell.speciesLabel.text = people.species
            collectionViewCell.cellImage.image = people.previewImage
            collectionViewCell.activityView.isHidden = true
            collectionViewCell.activityIndicator.stopAnimating()
            }
        }
        return collectionViewCell
    }
}

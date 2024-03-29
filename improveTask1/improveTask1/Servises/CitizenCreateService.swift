//
//  CitizenCreateService.swift
//  improveTask1
//
//  Created by 1234 on 12.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation
import UIKit


struct CitizenDataCache {
    static var urlArray : [String] = []
    static var dictionaryOfCitizen: Dictionary<String, Citizen> = [:]
}

struct Citizen {
    let name: String
    let species: String
    let gender: String
    var image = UIImage()
    var previewImage =  UIImage()
}

struct VocabularyOfCitizen {
    let url: String
    let citizen: Citizen
}

class CitizenCreateService: UIViewController {
    
    let networkService = NetworkService()
    var dictionaryOfCitizen: Dictionary<String, Citizen> = [:]
    
    func initiateModel() {
        var urls: [String] = []
        var citizens: [Citizen] = []
        for url in  CitizenDataCache.urlArray {
            urls.append(url)
            citizens.append(Citizen(name: "", species: "", gender: ""))
        }
        let keysWithValues = zip(urls, citizens)
        CitizenDataCache.dictionaryOfCitizen = Dictionary(uniqueKeysWithValues: keysWithValues)
    }
    
    func createOne(index: Int ,
                   completion: @escaping (Dictionary<String, Citizen>) -> Void,
                   imageCompletion: @escaping (Dictionary<String, Citizen>) -> Void) {
        
        DispatchQueue.global().async {
            self.networkService.getCitizen(for: CitizenDataCache.urlArray[index]) { [weak self] (response, error) in
                guard let self = self,
                      let response = response
                else { return }
                let dto = response
                var citizen = Citizen(name: dto.name, species: dto.species, gender: dto.gender)
                CitizenDataCache.dictionaryOfCitizen[CitizenDataCache.urlArray[index]] = citizen
                completion(CitizenDataCache.dictionaryOfCitizen)
                
                self.networkService.getImage(for: dto.image) { (image, error) in
                    guard let image = image else { return }
                    
                    citizen.image = image
                    let size = CGSize(width: 100, height: 100)
                    citizen.previewImage = image.scaledDown(into: size, centered: true)
                    CitizenDataCache.dictionaryOfCitizen[CitizenDataCache.urlArray[index]] = citizen
                    imageCompletion(CitizenDataCache.dictionaryOfCitizen)
                }
            }
        }
    }
}

extension UIImage {
    func scaledDown(into size: CGSize, centered: Bool = false) -> UIImage {
        var (targetWidth, targetHeight) = (self.size.width, self.size.height)
        var (scaleWidth, scaleHeight) = (1.0 as CGFloat, 1.0 as CGFloat)
        if targetWidth > size.width {
            scaleWidth = size.width/targetWidth
        }
        if targetHeight > size.height {
            scaleHeight = size.height/targetHeight
        }
        let scale = min(scaleWidth,scaleHeight)
        targetWidth *= scale; targetHeight *= scale
        let size = CGSize(width:targetWidth, height:targetHeight)
        if !centered {
            return UIGraphicsImageRenderer(size:size).image { _ in
                self.draw(in:CGRect(origin:.zero, size:size))
            }
        }
        let x = (size.width - targetWidth)/2
        let y = (size.height - targetHeight)/2
        let origin = CGPoint(x: x,y: y)
        return UIGraphicsImageRenderer(size:size).image { _ in
            self.draw(in: CGRect(origin: origin, size: size))
        }
    }
}


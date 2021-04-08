//
//  PlanetListResponceModel.swift
//  improveTask1
//
//  Created by 1234 on 05.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation


struct PlanetListResponceModel: Decodable {
    let info: PlanetListInfoResponceModel
    let results: [PlanetListResultResponceModel]
}

struct PlanetListInfoResponceModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
}

struct PlanetListResultResponceModel: Decodable {
let id: Int
let name: String?
let type: String?
let residents: [String]
}

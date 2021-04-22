//
//  PeopleListResponceModel.swift
//  improveTask1
//
//  Created by 1234 on 12.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation


struct CitizenResponseModel: Decodable {
    let name: String
    let gender: String
    let species: String
    let image: String
    let url: String
}

//
//  NetworkServices.swift
//  improveTask1
//
//  Created by 1234 on 05.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol PlanetsListNetworkService{
    func getPlanetList(page: Int,onRequestCompleted:@escaping ((PlanetListResponseModel?, Error?)->()))
}

protocol CitizenNetworkService{
    func getCitizen(for urlString: String, onRequestCompleted:@escaping ((CitizenResponseModel?, Error?)->()))
    func getImage(for urlString: String, onRequestCompleted:@escaping ((UIImage?, Error?)->()))
}

class NetworkService: PlanetsListNetworkService, CitizenNetworkService{
    func getCitizen(for urlString: String, onRequestCompleted: @escaping ((CitizenResponseModel?, Error?) -> ())) {
        performRequest(urlString: urlString, onRequestCompleted: onRequestCompleted)
    }
    
    func getImage(for urlString: String, onRequestCompleted:@escaping ((UIImage?, Error?)->())) {
        AF.request(urlString,
                   method: .get)
            .response{ response in
                switch response.result {
                case .success(let responseData):
                    if let data = responseData {
                        onRequestCompleted(UIImage(data: data, scale:1), nil)
                    } else {
                        onRequestCompleted(nil, response.error)
                    }
                case .failure(let error):
                    onRequestCompleted(nil, error)
                }
            }
    }
    
    func getPlanetList(page: Int,onRequestCompleted:@escaping ((PlanetListResponseModel?, Error?)->())) {
        
        performRequest(urlString: NetworkContstants.URLString.planetList + "?page=\(page)", onRequestCompleted: onRequestCompleted)
    }
    
    private func performRequest<ResponseModel:Decodable>(urlString: String, method: HTTPMethod = .get,onRequestCompleted: @escaping ((ResponseModel?, Error?)->())) {
        
        AF.request(urlString,
                   method: .get,
                   encoding: JSONEncoding.default).response { (responceData) in
                    guard responceData.error == nil,
                          let data =  responceData.data, data.count != 0
                    else {
                        onRequestCompleted(nil, responceData.error)
                        return
                    }
                    do {
                        let decodedValue: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                        onRequestCompleted(decodedValue, nil)
                    }
                    catch (let error) {
                        print("Response parsing error: \(error.localizedDescription)")
                        onRequestCompleted(nil, error)
                    }
                   }
    }
}

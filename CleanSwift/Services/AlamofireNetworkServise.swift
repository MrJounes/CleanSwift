//
//  AlamofireNetworkServise.swift
//  CleanSwift
//
//  Created by Igor Dikan on 02.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class AlamofireNetworkServise {
    
    func request(path: String, params: [String : String], complition: @escaping (Result<Data, Error>) -> Void) {
        var allParams = params
        allParams["apiKey"] = API.apiKey
        allParams["country"] = API.country
        let url = self.url(from: path, params: allParams)
        DispatchQueue.main.async {
            AF.request(url).responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let data = JSON(data)
                    
                    let articlesJSON = data["articles"].arrayValue
                    
                    print(articlesJSON)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}

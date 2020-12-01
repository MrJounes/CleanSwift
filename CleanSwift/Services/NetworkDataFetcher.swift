//
//  NetworkDataFetcher.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    private init() {}
    static let shared = NetworkDataFetcher()
    
    let networkService = NetworkService.shared
    
    func fetchArticles(urlString: String, response: @escaping (NewsResponseModel?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let articles = try  JSONDecoder().decode(NewsResponseModel.self, from: data)
                    response(articles)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error receieved requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}

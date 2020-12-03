//
//  NetworkService.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    private let apiKey = API.apiKey
    private let defaultUrl = "http://newsapi.org/v2/top-headlines?country=ru&apiKey=3bf2bcbc726d444ca580f2e0fa6c30be"
    
    func fetchNews(paht: String, params: [String : String], complition: @escaping (NewsResponseModel) -> Void) {
        var allParams = params
        allParams["apiKey"] = apiKey
        allParams["country"] = API.country
        let url = self.url(from: API.topHeadlines, params: allParams)
        
        AF.request(url)
            .validate()
            .responseDecodable(of: NewsResponseModel.self) { (response) in
                guard let news = response.value else { return }
                complition(news)
            }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else { return URL(string: defaultUrl)!}
        return url
    }
}

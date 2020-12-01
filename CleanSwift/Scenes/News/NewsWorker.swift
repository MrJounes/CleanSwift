//
//  NewsWorker.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

final class NewsService {
    
    func fetchNews(complition: @escaping ([Article]) -> Void) {
        let defaultValue: [Article] = []
        let urlString = "http://newsapi.org/v2/top-headlines?country=ru&apiKey=3bf2bcbc726d444ca580f2e0fa6c30be"
        NetworkDataFetcher.shared.fetchArticles(urlString: urlString) { (newsResponseModel) in
            complition(newsResponseModel?.articles ?? defaultValue)
        }
    }
}

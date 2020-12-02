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

        NetworkDataFetcher.shared.fetchArticles { (newsResponseModel) in
            complition(newsResponseModel?.articles ?? defaultValue)
        }
        
    }
}

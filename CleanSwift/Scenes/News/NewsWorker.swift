//
//  NewsWorker.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

final class NewsService {
    
    func fetchNews(complition: @escaping (NewsResponseModel) -> Void) {
        NetworkService.shared.fetchNews(paht: API.topHeadlines, params: [:]) { (news) in
            complition(news)
        }
    }
}

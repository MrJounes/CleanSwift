//
//  NewsInteractor.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsBusinessLogic {
    func makeRequest(request: News.Load.Request.RequestType)
}

final class NewsInteractor {
    
    // MARK: - External vars
    var presenter: NewsPresentationLogic?
    var service: NewsService?
    weak var viewController: NewsDisplayLogic?

}

// MARK: - Business logic
extension NewsInteractor: NewsBusinessLogic {
    func makeRequest(request: News.Load.Request.RequestType){
        switch request {
        case .getNews(recordsArray: let recordsArray):
            if service == nil {
                service = NewsService()
            }
            service?.fetchNews(complition: { (news) in
                self.presenter?.presentData(response: .presentNews(news: news, recordsArray: recordsArray))
            })
        case .getLogo(navController: let navController, navItem: let navItem):
            presenter?.presentData(response: .presentLogo(navController: navController, navItem: navItem))
        }
    }
}

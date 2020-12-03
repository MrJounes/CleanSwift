//
//  NewsPresenter.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsPresentationLogic {
    func presentData(response: News.Load.Response.ResponseType)
}

final class NewsPresenter {
    
    // MARK: - External vars
    weak var viewController: NewsDisplayLogic?
    
}

// MARK: - Presentation logic
extension NewsPresenter: NewsPresentationLogic {
    
    private struct DefaultValue {
        static let autor = "Автор не указан"
        static let date = "Дата не указана"
        static let title = "Заголовок не указан"
        static let text = "Описание отсутствует"
        static let imageUrl = "https://gobatumi.com/images/noimage.png"
    }
    
    func presentData(response: News.Load.Response.ResponseType) {
        switch response {
        case .presentNews(news: let news, recordsArray: var recordsArray):
            let viewModel = news.articles.map { (news) -> NewsCellModel in
                let newsCellModel = NewsCellModel(newsImage: news.urlToImage ?? DefaultValue.imageUrl,
                                                  newsTitle: news.title ?? DefaultValue.title,
                                                  newsText: news.description ?? DefaultValue.text,
                                                  newsAutor: news.author ?? DefaultValue.autor,
                                                  newsDate: DateConversionService.shared.getDate(dateString: news.publishedAt ?? DefaultValue.date),
                                                  newsCountShape: String(Int.random(in: 5...19)))
                return newsCellModel
            }
            var index = 0
                        while index < 4 {
                            let article = viewModel[index]
                            recordsArray.append(article)
                            index = index + 1
            }
            viewController?.displayData(viewModel: .displayNews(news: viewModel, recordsArray: recordsArray))
            
        case .presentLogo(navController: let navController, navItem: let navItem):
            if navController != nil {
                let imageLogo = UIImage(named: "NewsLogo")
                let widhtForView = 163
                let heightForView = 14
                let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: widhtForView, height: heightForView))
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widhtForView, height: heightForView))
                imageView.image = imageLogo
                logoContainer.contentMode = .scaleAspectFit
                logoContainer.addSubview(imageView)
                navItem.titleView = logoContainer
            }
            viewController?.displayData(viewModel: .displayLogo)
        }
    }
}

//
//  NewsPresenter.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsPresentationLogic {
    func presentData(response: News.Something.Response.ResponseType)
    func presentLogo(navController: UINavigationController?, navItem: UINavigationItem)
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
        static let text = ""
        static let imageUrl = "https://gobatumi.com/images/noimage.png"
    }
    
    
    func presentLogo(navController: UINavigationController?, navItem: UINavigationItem) {
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
        viewController?.displayLogo()
    }
    
    func presentData(response: News.Something.Response.ResponseType) {
        switch response {
        case .presentNews(news: let news):
            let viewModel = news.map { (news) -> NewsCellModel in
                let newsCellModel = NewsCellModel(newsImage: news.urlToImage ?? DefaultValue.imageUrl,
                                                  newsTitle: news.title ?? DefaultValue.title,
                                                  newsText: news.description ?? DefaultValue.text,
                                                  newsAutor: news.author ?? DefaultValue.autor,
                                                  newsDate: DateConversionService.shared.getDate(dateString: news.publishedAt ?? DefaultValue.date),
                                                  newsCountShape: String(Int.random(in: 5...19)))
                return newsCellModel
            }
            
            viewController?.displayData(viewModel: .displayNews(news: viewModel))
        }
    }
}

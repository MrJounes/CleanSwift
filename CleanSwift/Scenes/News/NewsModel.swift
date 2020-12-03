//
//  NewsModel.swift
//  CleanSwift
//
//  Created by Igor Dikan on 01.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

enum News {
    
    enum Load {
        struct Request {
            enum RequestType {
                case getNews(recordsArray: [NewsCellModel])
                case getLogo(navController: UINavigationController?, navItem: UINavigationItem)
            }
        }
        struct Response {
            enum ResponseType {
                case presentNews(news: NewsResponseModel, recordsArray: [NewsCellModel])
                case presentLogo(navController: UINavigationController?, navItem: UINavigationItem)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNews(news: [NewsCellModel], recordsArray: [NewsCellModel])
                case displayLogo
            }
        }
    }
}

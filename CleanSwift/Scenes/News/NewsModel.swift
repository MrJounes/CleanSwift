//
//  NewsModel.swift
//  CleanSwift
//
//  Created by Igor Dikan on 01.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

enum News {
// MARK: Use cases

    enum Something {
        struct Request {
            enum RequestType {
                case getNews
            }
        }
        struct Response {
            enum ResponseType {
                case presentNews(news: [Article])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNews(news: [NewsCellModel])
            }
        }
    }
}

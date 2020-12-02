//
//  API.swift
//  CleanSwift
//
//  Created by Igor Dikan on 02.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

struct API {
    // http://newsapi.org/v2/top-headlines?country=ru&apiKey=3bf2bcbc726d444ca580f2e0fa6c30be
    static let scheme = "http"
    static let host = "newsapi.org"
    
    static let topHeadlines = "/v2/top-headlines"
    
    static let country = "ru"
    static let apiKey = "3bf2bcbc726d444ca580f2e0fa6c30be"
}

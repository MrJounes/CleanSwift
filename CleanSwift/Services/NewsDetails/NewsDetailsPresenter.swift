//
//  NewsDetailsPresenter.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

protocol NewsDetailsPresentationLogic {
    func presentData(response: NewsDetails.Something.Response.ResponseType)
}

final class NewsDetailsPresenter {
    
    // MARK: - External vars
    weak var viewController: NewsDetailsDisplayLogic?
}

// MARK: - Presentation logic
extension NewsDetailsPresenter: NewsDetailsPresentationLogic {
    
    func presentData(response: NewsDetails.Something.Response.ResponseType) {
        switch response {
        case .presentDetails(details: let details):
            viewController?.displayData(data: .displayDetails(details: details))
        }
    }
}

//
//  NewsDetailsInteractor.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

protocol NewsDetailsBusinessLogic {
    func makeRequest(request: NewsDetails.Something.Request.RequestType)
}

protocol NewsDetailsStoreProtocol: class {
    var dataToDisplay: NewsCellModel? { get set }
}

final class NewsDetailsInteractor: NewsDetailsStoreProtocol {
    
    // MARK: - External vars
    var presenter: NewsDetailsPresentationLogic?
    
    // MARK: - Internal vars
    var dataToDisplay: NewsCellModel?
    
}

// MARK: - Business logic
extension NewsDetailsInteractor: NewsDetailsBusinessLogic {
    
    func makeRequest(request: NewsDetails.Something.Request.RequestType) {
        switch request {
        case .fetchDetails:
            guard let dataToDisplay = self.dataToDisplay else { return }
            presenter?.presentData(response: .presentDetails(details: dataToDisplay))
        }
    }
}

//
//  NewsDetailsRouter.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

protocol NewsDetailsRoutingLogic {
    
}

protocol NewsDetailsDataPassingProtocol {
    var dataStore: NewsDetailsStoreProtocol? { get }
}

final class NewsDetailsRouter: NewsDetailsDataPassingProtocol {
    
    // MARK: - External vars
    weak var dataStore: NewsDetailsStoreProtocol?
    
}

// MARK: - Routing logic
extension NewsDetailsRouter: NewsDetailsRoutingLogic {
    
}

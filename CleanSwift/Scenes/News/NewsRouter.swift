//
//  NewsRouter.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsRoutingLogic {
    func navigateToDetail(data: NewsCellModel)
}

final class NewsRouter {
    
    // MARK: - External vars
    weak var viewController: UIViewController?
}

// MARK: - Routing logic
extension NewsRouter: NewsRoutingLogic {
    func navigateToDetail(data: NewsCellModel) {
        let storyboard = UIStoryboard.init(name: "NewsDetailsViewController", bundle: nil)
        guard let newsDetailsVC = storyboard.instantiateViewController(identifier: "NewsDetailsViewController") as? NewsDetailsViewController else { return }
        
        newsDetailsVC.router?.dataStore?.dataToDisplay = data
        viewController?.navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
}

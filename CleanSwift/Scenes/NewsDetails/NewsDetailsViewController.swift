//
//  NewsDetailsViewController.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsDetailsDisplayLogic: class {
    func displayData(data: NewsDetails.Something.ViewModel.ViewModelData)
}

final class NewsDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var detailsAutorLabel: UILabel!
    @IBOutlet private weak var detailsDateLabel: UILabel!
    @IBOutlet private weak var detailsTitleLabel: UILabel!
    @IBOutlet private weak var detailsImageView: UIImageView!
    @IBOutlet private weak var detailsTextLabel: UILabel!
    
    // MARK: - External vars
    private(set) var router: (NewsDetailsRoutingLogic & NewsDetailsDataPassingProtocol)?
    
    // MARK: - Internal vars
    private var interactor: (NewsDetailsBusinessLogic & NewsDetailsStoreProtocol)?
    private var detailsData: NewsCellModel?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = NewsDetailsInteractor()
        let presenter = NewsDetailsPresenter()
        let router = NewsDetailsRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Статья"
        // Do any additional setup after loading the view.
        interactor?.makeRequest(request: .fetchDetails)
        configureDetails(data: detailsData)
    }
    
    // MARK: - Internal logic
    private func configureDetails(data: NewsCellModel?) {
        detailsAutorLabel.text = data?.newsAutor
        detailsDateLabel.text = data?.newsDate
        detailsTitleLabel.text = data?.newsTitle.uppercased()
        detailsImageView.setImage(urlString: data?.newsImage ?? "")
        detailsTextLabel.text = data?.newsText
    }
}

// MARK: - Display logic
extension NewsDetailsViewController: NewsDetailsDisplayLogic {
    
    func displayData(data: NewsDetails.Something.ViewModel.ViewModelData) {
        switch data {
        case .displayDetails(details: let details):
            self.detailsData = details
        }
    }
}

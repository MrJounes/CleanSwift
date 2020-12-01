//
//  NewsViewController.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsDisplayLogic: class {
    func displayData(viewModel: News.Something.ViewModel.ViewModelData)
    func displayLogo()
}

protocol NewsCellDelegate: class {
    func didNewsTap(dataNews: NewsCellModel)
}

final class NewsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - External vars
    private(set) var router: NewsRoutingLogic?
    weak var newsCellDelegate: NewsCellDelegate?
    
    // MARK: - Internal vars
    private var interactor: NewsBusinessLogic?
    private var dataToDisplay = [NewsCellModel]()
    private var dataToRoute: NewsCellModel?
    
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
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let router = NewsRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsCellDelegate = self
        configureTableView()
        // Do any additional setup after loading the view.
        interactor?.makeRequest(request: .getNews)
    }

    // MARK: - Internal logic
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register( UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.cellIndetifier)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        interactor?.getLogo(navController: navigationController, navItem: navigationItem)
    }
}

// MARK: - Display logic
extension NewsViewController: NewsDisplayLogic {
    
    func displayData(viewModel: News.Something.ViewModel.ViewModelData){
        switch viewModel {
        case .displayNews(news: let news):
            dataToDisplay.removeAll()
            dataToDisplay.append(contentsOf: news)
            tableView.reloadData()
        }
    }
    
    func displayLogo() {
        
    }
}

// MARK: - NewsCellDelegate
extension NewsViewController: NewsCellDelegate {
    func didNewsTap(dataNews: NewsCellModel) {
        guard let dataToRoute = self.dataToRoute else { return }
        router?.navigateToDetail(data: dataToRoute)
    }
}

// MARK: - UITableViewDelegate 
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dataToRoute = dataToDisplay[indexPath.row]
        guard let dataToRoute = self.dataToRoute else { return }
        newsCellDelegate?.didNewsTap(dataNews: dataToRoute)
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIndetifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.setup(data: dataToDisplay[indexPath.row])
        return cell
    }

}

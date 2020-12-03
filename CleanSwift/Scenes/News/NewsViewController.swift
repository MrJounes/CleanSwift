//
//  NewsViewController.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDisplayLogic: class {
    func displayData(viewModel: News.Load.ViewModel.ViewModelData)
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
    
    private var recordsArray = [NewsCellModel]()
    private var limit = 4
    private var totalEnetries = 20
    
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
        
    }

    // MARK: - Internal logic
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register( UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.cellIndetifier)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        interactor?.makeRequest(request: .getLogo(navController: navigationController, navItem: navigationItem))
        addLoadMoreButton()
        fetchNews()
    }
    
    private func fetchNews() {
        interactor?.makeRequest(request: .getNews(recordsArray: recordsArray))
    }
    
    private func addLoadMoreButton() {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.tableView.frame.width, height: 40)))
        button.setTitle("Загрузить еще", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
        self.tableView.tableFooterView = button
    }
        
    @objc func moreButtonClicked(_ sender: UIButton) {
        if recordsArray.count < totalEnetries && recordsArray.count < totalEnetries + 4{
            var index = recordsArray.count
            limit = index + 4
            while index < limit {
                let article = self.dataToDisplay[index]
                recordsArray.append(article)
                index = index + 1
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Display logic
extension NewsViewController: NewsDisplayLogic {
    func displayData(viewModel: News.Load.ViewModel.ViewModelData){
        switch viewModel {
        case .displayNews(news: let news, recordsArray: let recordsArray):
            dataToDisplay.removeAll()
            dataToDisplay.append(contentsOf: news)
            self.recordsArray = recordsArray
            tableView.reloadData()
        case .displayLogo:
            break
        }
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
        //return dataToDisplay.count
        return recordsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIndetifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.setup(data: dataToDisplay[indexPath.row])
        return cell
    }

}

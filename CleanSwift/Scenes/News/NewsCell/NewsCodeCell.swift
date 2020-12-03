//
//  NewsCodeCell.swift
//  CleanSwift
//
//  Created by Igor Dikan on 03.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let newsTitleFont = UIFont(name: "PTRootUI-Medium", size: 20)
    static let newsAuthorFont = UIFont(name: "PTRootUI-Regular", size: 12)
    static let newsDateFont = UIFont(name: "PTRootUI-Light", size: 12)
    static let newsCountCommentFont = UIFont(name: "PTRootUI-Light", size: 12)
    static let commentImageSize: CGFloat = 12
    static let newsImageAspectRatio: CGFloat = 343/195
    static let padding22: CGFloat = 22
    static let padding18: CGFloat = 18
    static let padding16: CGFloat = 16
    static let padding12: CGFloat = 12
    static let padding8: CGFloat = 8
    static let padding6: CGFloat = 6
}

final class NewsCodeCell: UITableViewCell {
    
    static let reuseId = "NewsCodeCell"
    
    // MARK: - Internal vars
    let newsCellContentView: UIView
    let newsImageView: UIImageView
    let newsTitleLabel: UILabel
    let newsAuthorLabel: UILabel
    let newsDateLabel: UILabel
    let newsCommentImageView: UIImageView
    let newsCountCommentLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        newsCellContentView = UIView()
        newsImageView = UIImageView()
        newsTitleLabel = UILabel()
        newsAuthorLabel = UILabel()
        newsDateLabel = UILabel()
        newsCommentImageView = UIImageView()
        newsCountCommentLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCusomizeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal logic
    func setup(data: NewsCellModel) {
        newsImageView.setImage(urlString: data.newsImage)
        newsImageView.contentMode = .scaleAspectFit
        newsTitleLabel.text = data.newsTitle.uppercased()
        newsTitleLabel.numberOfLines = 0
        newsAuthorLabel.text = data.newsAutor
        newsDateLabel.text = data.newsDate
        newsCommentImageView.image = UIImage(named: "Shape")
        newsCountCommentLabel.text = data.newsCountShape
    }
}

// MARK: - Customize view
extension NewsCodeCell {
    
    private func initCusomizeView() {
        setupComponents()
        setupFonts()
        setupConstraints()
    }
    
    private func setupComponents() {
        addSubviewForAutoLayout(newsCellContentView)
        newsCellContentView.addSubviewForAutoLayout(newsImageView)
        newsCellContentView.addSubviewForAutoLayout(newsTitleLabel)
        newsCellContentView.addSubviewForAutoLayout(newsAuthorLabel)
        newsCellContentView.addSubviewForAutoLayout(newsDateLabel)
        newsCellContentView.addSubviewForAutoLayout(newsCommentImageView)
        newsCellContentView.addSubviewForAutoLayout(newsCountCommentLabel)
    }
    
    private func setupFonts(){
        newsTitleLabel.font = Constants.newsTitleFont
        newsAuthorLabel.font = Constants.newsAuthorFont
        newsDateLabel.font = Constants.newsDateFont
        newsCountCommentLabel.font = Constants.newsCountCommentFont
    }
    
    private func setupConstraints() {
        // newsContentView constraints
        newsCellContentView.fillSuperview()
        // newsImageView constraints
        newsImageView.leadingAnchor.constraint(equalTo: newsCellContentView.leadingAnchor, constant: Constants.padding16).isActive = true
        newsImageView.topAnchor.constraint(equalTo: newsCellContentView.topAnchor, constant: Constants.padding16).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: newsCellContentView.trailingAnchor, constant: -Constants.padding16).isActive = true
        newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor, multiplier: Constants.newsImageAspectRatio).isActive = true
        
        // newsTitleLabel constraints
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsCellContentView.leadingAnchor, constant: Constants.padding16).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: Constants.padding16).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: newsCellContentView.trailingAnchor, constant: -Constants.padding16).isActive = true
        
        // newsAuthorLabel constraints
        newsAuthorLabel.leadingAnchor.constraint(equalTo: newsCellContentView.leadingAnchor, constant: Constants.padding16).isActive = true
        newsAuthorLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Constants.padding8).isActive = true
        newsAuthorLabel.bottomAnchor.constraint(equalTo: newsCellContentView.bottomAnchor, constant: -Constants.padding18).isActive = true
        
        // newsDateLabel constraints
        newsDateLabel.leadingAnchor.constraint(equalTo: newsAuthorLabel.trailingAnchor, constant: Constants.padding18).isActive = true
        newsDateLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Constants.padding8).isActive = true
        newsDateLabel.bottomAnchor.constraint(equalTo: newsCellContentView.bottomAnchor, constant: -Constants.padding18).isActive = true
        
        // newsCommentImageView constraints
        newsCommentImageView.leadingAnchor.constraint(equalTo: newsDateLabel.trailingAnchor, constant: Constants.padding18).isActive = true
        newsCommentImageView.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Constants.padding12).isActive = true
        newsCommentImageView.bottomAnchor.constraint(equalTo: newsCellContentView.bottomAnchor, constant: -Constants.padding22).isActive = true
        newsCommentImageView.heightAnchor.constraint(equalToConstant: Constants.commentImageSize).isActive = true
        newsCommentImageView.widthAnchor.constraint(equalToConstant: Constants.commentImageSize).isActive = true
        
        // newsCountCommentLabel constraints
        newsCountCommentLabel.leadingAnchor.constraint(equalTo: newsCommentImageView.trailingAnchor, constant: Constants.padding6).isActive = true
        newsCountCommentLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: Constants.padding8).isActive = true
        newsCountCommentLabel.bottomAnchor.constraint(equalTo: newsCellContentView.bottomAnchor, constant: -Constants.padding16).isActive = true
        newsCountCommentLabel.trailingAnchor.constraint(lessThanOrEqualTo: newsCellContentView.trailingAnchor, constant: -Constants.padding16).isActive = true
    }

}

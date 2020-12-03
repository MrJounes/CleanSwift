//
//  NewsCell.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

//protocol NewsCellDelegate: class {
//    func didNewsTap(dataNews: [NewsCellModel])
//}

final class NewsCell: UITableViewCell {

    static let cellIndetifier = "NewsCell"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsAutorLabel: UILabel!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsShapeImageView: UIImageView!
    @IBOutlet private weak var newsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: NewsCellModel) {
        newsImageView.setImage(urlString: data.newsImage)
        newsTitleLabel.text = data.newsTitle.uppercased()
        newsAutorLabel.text = data.newsAutor
        newsDateLabel.text = data.newsDate
        newsCountLabel.text = data.newsCountShape
    }
}

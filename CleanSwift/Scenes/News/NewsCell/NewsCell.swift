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

class NewsCell: UITableViewCell {

    static let cellIndetifier = "NewsCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var newsImageView: WebImageViewService!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAutorLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsShapeImageView: UIImageView!
    @IBOutlet weak var newsCountLabel: UILabel!
    
    // MARK: - External vars
    private var dataNews: [NewsCellModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: NewsCellModel) {
        newsImageView.set(urlString: data.newsImage)
        newsTitleLabel.text = data.newsTitle.uppercased()
        newsAutorLabel.text = data.newsAutor
        newsDateLabel.text = data.newsDate
        newsCountLabel.text = data.newsCountShape
    }
}

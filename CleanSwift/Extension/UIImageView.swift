//
//  UIImageView.swift
//  CleanSwift
//
//  Created by Igor Dikan on 02.12.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String) {
        self.kf.setImage(with: URL(string: urlString))
    }
}

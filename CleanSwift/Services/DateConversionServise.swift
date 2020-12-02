//
//  DateConversionServise.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

class DateConversionService {
    
    private init() {}
    static let shared = DateConversionService()
    
    let defaultValue = "1970-01-01"
    
    func getDate(dateString: String?) -> String {
        guard let dateString = dateString else { return defaultValue }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "dd MMMM 'в' HH:mm"
        return formatter.string(from: date!)
    }
}

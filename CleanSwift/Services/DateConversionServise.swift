//
//  DateConversionServise.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 29.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import Foundation

final class DateConversionService {
    
    private init() {}
    static let shared = DateConversionService()
    
    let defaultValue = "1970-01-01"
    
    func getDate(dateString: String?) -> String {
        guard let dateString = dateString else { return defaultValue }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.date(from: dateString) else { return defaultValue }
        formatter.dateFormat = "dd MMMM 'в' HH:mm"
        return formatter.string(from: date)
    }
}

//
//  Date+Extension.swift
//  GitHub Followers
//
//  Created by Злобин Сергей Александрович on 24.10.2022.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
        
    }
}

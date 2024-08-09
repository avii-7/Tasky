//
//  Date+Extensions.swift
//  Tasky
//
//  Created by Arun on 07/08/24.
//

import Foundation

extension Date {
    
    func toTaskDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

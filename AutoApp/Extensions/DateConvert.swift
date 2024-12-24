//
//  DateConvert.swift
//  AutoApp
//
//  Created by IGOR on 23/12/2024.
//

import SwiftUI

extension Date {
    
    func convertDate(format: String) -> String {
        
        let date = self
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

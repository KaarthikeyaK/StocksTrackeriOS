//
//  Staticstics.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 31/08/23.
//

import Foundation


struct Statistic: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil){ // PercentageChange will be nil by default. If we want a value, we can add it. 
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

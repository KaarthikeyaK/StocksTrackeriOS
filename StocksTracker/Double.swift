//
//  Double.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 21/08/23.
//

import Foundation

extension Double {
    
    /// Convertes the Double into a Currency with a 2 - 6 Decimal places
    ///```
    /// Convert 1234.56 = $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "inr"
        formatter.currencySymbol = "₹"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convertes the Double into a Currency as a String with a 2  Decimal places
    ///```
    /// Convert 1234.56 = "$1,234.56"
    /// ```
    func asCurrencywith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Convertes the Double into a Currency with a 2 - 6 Decimal places
    ///```
    /// Convert 1234.56 = $1,234.56
    /// Convert 12.3456 = $12.3456
    /// Convert 0.1234567 = $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "inr"
        formatter.currencySymbol = "₹"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convertes the Double into a Currency as a String with a 2 - 6 Decimal places
    ///```
    /// Convert 1234.56 = "$1,234.56"
    /// Convert 12.3456 = "$12.3456"
    /// Convert 0.1234567 = "$0.123456"
    /// ```
    func asCurrencywith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convertes the Double into a String Representation
    ///```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convertes the Double into a String Representation with % symbol
    ///```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}

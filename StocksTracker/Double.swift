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
    
    ///Convert a Double to a String with K, M, Bn, Tr abbrevetions
    ///```
    ///Convert 12 to 12.00
    ///Convert 1234 to 1.23K
    ///Convert 123456 to 123.45K
    ///Convert 12345678 to 12.34M
    ///Convert 1234567890 to 1.23Bn
    ///Convert 12345678901234 to 12.34Tr
    ///```
    func formattedWithAbbreavations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
            
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
        
    }
}

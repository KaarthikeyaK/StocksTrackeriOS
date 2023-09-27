//
//  String.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 27/09/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

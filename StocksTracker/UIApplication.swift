//
//  UIApplication.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 30/08/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

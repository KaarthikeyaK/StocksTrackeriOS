//
//  HapticManager.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 25/09/23.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

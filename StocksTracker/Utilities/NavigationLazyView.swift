//
//  NavigationLazyView.swift
//  PaperCoin
//
//  Created by KAARTHIKEYA K on 26/09/23.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

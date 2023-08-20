//
//  CircleButtonView.swift
//  StocksTracker
//
//  Created by KAARTHIKEYA K on 20/08/23.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(.headline))
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
                    .shadow(color: .theme.accent.opacity(0.25), radius: 8)
            )
            .padding()
            
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(imageName: "plus")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(imageName: "info")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

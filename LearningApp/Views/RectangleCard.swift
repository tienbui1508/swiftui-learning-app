//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Tien Bui on 18/4/2023.
//

import SwiftUI

struct RectangleCard: View {
    var color = Color.white
    var height = CGFloat(48)
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}

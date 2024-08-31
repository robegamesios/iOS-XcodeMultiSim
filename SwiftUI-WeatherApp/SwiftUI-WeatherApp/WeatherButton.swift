//
//  WeatherButton.swift
//  SwiftUI-WeatherApp
//
//  Created by rob enriquez on 6/19/24.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .medium))
            .cornerRadius(10)
    }
}


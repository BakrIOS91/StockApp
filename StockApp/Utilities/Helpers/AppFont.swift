//
//  AppFont.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftUI

// MARK: - View Modifier
struct TextStyleModifier: ViewModifier {
    
    let weight: Font.Weight
    let size: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(color)
    }
}

// MARK: - View Extension
extension View {
    
    func textStyle(
        weight: Font.Weight = .regular,
        size: CGFloat = 16,
        color: Color = .appBlack
    ) -> some View {
        
        let scalingFactor = DeviceHelper.getScalingFactor()
        let fontSize = size * scalingFactor
        
        return self
            .modifier(
                TextStyleModifier(
                    weight: weight,
                    size: fontSize,
                    color: color
                )
            )
            .dynamicTypeSize(.small ... .xxxLarge)
    }
}

//
//  AppFont.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftUI

enum FontWeight: String {
    case bold
    case regular
    case medium
    
    var suffix: String {
        switch self {
        case .bold: return "Bold"
        case .regular: return "Regular"
        case .medium: return "Medium"
        }
    }
}

@MainActor
struct FontHelper {
    static func font(size: CGFloat, weight: FontWeight, color: Color) -> (font: UIFont, color: UIColor) {
        let fontName = "OpenSans-\(weight.suffix)"
        let scalingFactor = DeviceHelper.getScalingFactor()
        let fontSize = size * scalingFactor
        let customFont = UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: size)
        return (font: customFont, color: color.uiColor)
    }
    
    static func fontName() -> String {
        return "OpenSans"
    }
    
    static func fontWeight(for weight: FontWeight) -> String {
        return weight.suffix
    }
}

struct TextStyleModifier: ViewModifier {
    let fontWeight: FontWeight
    let size: CGFloat
    let color: Color
    let fontName: String
    
    init(fontWeight: FontWeight, size: CGFloat, color: Color) {
        self.size = size
        self.fontWeight = fontWeight
        self.color = color
        self.fontName = "OpenSans-\(fontWeight.suffix)"
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: size))
            .foregroundColor(color)
    }
}


extension View {
    func textStyle(fontWeight: FontWeight = .regular, size: CGFloat = 16, color: Color = .appBlack) -> some View {
        let scalingFactor = DeviceHelper.getScalingFactor()
        let fontSize = size * scalingFactor
        return self.modifier(TextStyleModifier(fontWeight: fontWeight, size: fontSize, color: color))
                    .dynamicTypeSize(.small ... .xxxLarge)
    }
}

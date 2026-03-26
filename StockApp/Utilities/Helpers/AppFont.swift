import SwiftUI
import BMSwiftUI

#if os(iOS)
import UIKit
#endif

// MARK: - Font Weight
public enum FontWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
    
    var suffix: String {
        self.rawValue
    }
}

// MARK: - Font Helper
public enum FontHelper {
    public static func fontName() -> String {
        "OpenSans"
    }
    
    public static func fontWeight(for weight: FontWeight) -> String {
        weight.suffix
    }
    
    #if os(iOS)
    public static func font(size: CGFloat, weight: FontWeight, color: Color) -> (UIFont, UIColor) {
        // Since OpenSans is not found, we use system font as fallback
        let font = UIFont(name: "\(fontName())-\(weight.suffix)", size: size) ?? .systemFont(ofSize: size, weight: weight.uiWeight)
        return (font, color.uiColor)
    }
    #endif
}

#if os(iOS)
extension FontWeight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .bold: return .bold
        case .regular: return .regular
        case .medium: return .medium
        }
    }
}
#endif

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

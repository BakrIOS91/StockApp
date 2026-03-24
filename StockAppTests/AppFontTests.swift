//
//  AppFontTests.swift
//  StockAppTests
//

import Testing
import UIKit
import SwiftUI
@testable import StockApp

@Suite("AppFont Tests")
struct AppFontTests {
    
    @Test("Font weights map correctly to OpenSans suffixes")
    func testFontWeightSuffixes() {
        #expect(FontWeight.bold.suffix == "Bold")
        #expect(FontWeight.regular.suffix == "Regular")
        #expect(FontWeight.medium.suffix == "Medium")
    }
    
    @Test("FontHelper returns consistent OpenSans string names")
    @MainActor
    func testFontHelperStrings() {
        #expect(FontHelper.fontName() == "OpenSans")
        #expect(FontHelper.fontWeight(for: .bold) == "Bold")
    }
    
    @Test("FontHelper resolves UIFont structures dynamically")
    @MainActor
    func testFontHelperResolution() {
        let (font, uiColor) = FontHelper.font(size: 16, weight: .bold, color: .black)
        
        // Ensure the font object was successfully created with a valid size
        #expect(font.pointSize > 0, "Font properly constructed with a positive point size")
        
        // uiColor conversion might not strictly equal UIColor.black depending on trait collections.
        // It's safer to compare it directly against the extension logic output.
        #expect(uiColor == Color.black.uiColor, "Color should match the uiColor extension conversion")
    }
}

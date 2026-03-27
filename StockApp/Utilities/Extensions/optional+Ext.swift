//
//  optional+Ext.swift
//  StockApp
//
//  Created by Bakr Mohamed on 27/03/2026.
//

import SwiftUI

// MARK: - Double Formatting Extension
extension Optional where Wrapped == Double {
    /// Formats the optional Double to a string with comma separator and 2 decimal digits
    var formattedWithSeparator: String {
        guard let value = self else { return "0.00" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

//
//  Int+Ext.swift
//  StockApp
//
//  Created by Bakr Mohamed on 27/03/2026.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

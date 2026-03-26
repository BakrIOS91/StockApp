//
//  StockList.swift
//  StockApp
//

import Foundation
import SwiftUI

struct StockList: Codable {
    let marketSummaryAndSparkResponse: MarketSummaryAndSparkResponse?
    
    static var mock: StockList {
        StockList(marketSummaryAndSparkResponse: .mock)
    }
}

// MARK: - MarketSummaryAndSparkResponse
struct MarketSummaryAndSparkResponse: Codable {
    let result: [StockListem]?
    let error: String?
    
    static var mock: MarketSummaryAndSparkResponse {
        MarketSummaryAndSparkResponse(result: StockListem.mock, error: nil)
    }
}

// MARK: - Stock Status
enum StockStatus: String {
    case up
    case down
    case neutral

    var statucColor: Color {
        switch self {
        case .up: return .tealGreen
        case .down: return .darkRedColor
        case .neutral: return .gray
        }
    }
}

// MARK: - Stock Item
struct StockListem: Codable, Identifiable {
    var id: String { symbol ?? UUID().uuidString }
    
    var shortName: String?
    var fullExchangeName: String?
    var symbol: String?
    var regularMarketPrice: RegularMarket?
    var regularMarketPreviousClose: RegularMarket?
    
    // MARK: - Computed Properties
    
    var stockName: String {
        shortName ?? fullExchangeName ?? symbol ?? "Unknown"
    }
    
    var price: String {
        regularMarketPrice?.fmt ?? "N/A"
    }
    
    var changePercent: Double {
        guard let current = regularMarketPrice?.raw,
              let previous = regularMarketPreviousClose?.raw,
              previous != 0 else {
            return 0.0
        }
        
        let value = ((current - previous) / previous) * 100.0
        return (value * 10).rounded() / 10
    }
    
    var changePercentText: String {
        String(format: "%.1f%%", changePercent)
    }
    
    var status: StockStatus {
        if changePercent > 0 {
            return .up
        } else if changePercent < 0 {
            return .down
        } else {
            return .neutral
        }
    }
    
    var statusColorHex: String {
        switch status {
        case .up: return "#26D117"
        case .down: return "#FF1744"
        case .neutral: return "#3A3A3C"
        }
    }
    
    var statusSymbol: String {
        switch status {
        case .up: return "▲"
        case .down: return "▼"
        case .neutral: return ""
        }
    }
    
    // MARK: - Realistic Mock Data
    static var mock: [StockListem] {
        [
            // 🔼 UP
            StockListem(
                fullExchangeName: "Apple",
                symbol: "AAPL",
                regularMarketPrice: RegularMarket(raw: 175.5, fmt: "175.50"),
                regularMarketPreviousClose: RegularMarket(raw: 170.0, fmt: "170.00")
            ),
            
            // 🔽 DOWN
            StockListem(
                fullExchangeName: "Microsoft",
                symbol: "MSFT",
                regularMarketPrice: RegularMarket(raw: 310.0, fmt: "310.00"),
                regularMarketPreviousClose: RegularMarket(raw: 320.0, fmt: "320.00")
            ),
            
            // ➖ NEUTRAL
            StockListem(
                fullExchangeName: "Google",
                symbol: "GOOGL",
                regularMarketPrice: RegularMarket(raw: 125.0, fmt: "125.00"),
                regularMarketPreviousClose: RegularMarket(raw: 125.0, fmt: "125.00")
            ),
            
            // 🔼 small gain
            StockListem(
                fullExchangeName: "Amazon",
                symbol: "AMZN",
                regularMarketPrice: RegularMarket(raw: 102.3, fmt: "102.30"),
                regularMarketPreviousClose: RegularMarket(raw: 101.8, fmt: "101.80")
            ),
            
            // 🔽 small loss
            StockListem(
                fullExchangeName: "Tesla",
                symbol: "TSLA",
                regularMarketPrice: RegularMarket(raw: 245.2, fmt: "245.20"),
                regularMarketPreviousClose: RegularMarket(raw: 250.0, fmt: "250.00")
            )
        ]
    }
}

// MARK: - Regular Market
struct RegularMarket: Codable {
    let raw: Double?
    let fmt: String?
}

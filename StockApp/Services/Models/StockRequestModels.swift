//
//  StockRequestModels.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

struct StockRequestModel {
    var symbol: String
    var region: String
    
    enum CodingKeys: String, CodingKey {
        case symbol, region
    }
    
    init(symbol: String, region: String = "US") {
        self.symbol = symbol
        self.region = region
    }
}

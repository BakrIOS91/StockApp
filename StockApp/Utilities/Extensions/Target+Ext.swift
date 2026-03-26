//
//  Target+Ext.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import BMSwiftNetworking

extension ModelTargetType {
    public var headers: [String : String] {
        return [
            "x-rapidapi-host": AppEnvironments.apiHost,
            "x-rapidapi-key": AppEnvironments.apiKey
        ]
    }
}

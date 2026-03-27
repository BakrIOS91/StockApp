//
//  StockRequests.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//
import BMSwiftNetworking

struct GetStockList: ModelTargetType {
    typealias Response = StockList?
    
    var baseURL: String { return AppTarget.shared.kBaseURL }
    
    var requestPath: String { return "market/v2/get-summary" }
    
    var requestMethod: BMSwiftNetworking.HTTPMethod { return .GET }
        
    var requestTask: RequestTask {
        return .parameters(
            [
                "region": "US"
            ]
        )
    }
    
    
    var mockResponse: StockList? { return StockList.mock }
    
}


struct GetStockDetails: ModelTargetType {
    typealias Response = StockDetailsResponse?
    
    var request: StockRequestModel
    
    var baseURL: String { return AppTarget.shared.kBaseURL }
    
    var requestPath: String { return "market/v2/get-quotes" }
    
    var requestMethod: BMSwiftNetworking.HTTPMethod { return .GET }
    
    var requestTask: RequestTask {
        .parameters([
            "symbols": request.symbol,
            "region": request.region
        ])
    }
    
    init(request: StockRequestModel) {
        self.request = request
    }
}

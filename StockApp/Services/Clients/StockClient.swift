//
//  StockClient.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import BMSwiftNetworking
import BMSwiftUI

struct StockClient {
    var getStocks: () async -> AsyncStream<Result<StockList?, APIError>>
}

extension DependencyValues {
    var stockClient: StockClient {
        get { self[StockClient.self] }
        set { self[StockClient.self] = newValue }
    }
}

extension StockClient: DependencyKey {
    static var liveValue: StockClient {
        .init(
           getStocks: {
               GetStockList().performResultStream(repeatingEverySeconds: 8)
           }
        )
    }
    
    static var previewValue: StockClient {
        .init(
            getStocks: {
                AsyncStream { 
                    return .success(.mock)
                }
            }
        )
    }
    
    static var testValue: StockClient {
        .init(
            getStocks: {
                AsyncStream { 
                    return .success(.mock)
                }
            }
        )
    }
    
    static var noNetworkValue: StockClient {
        .init(
            getStocks: {
                AsyncStream { 
                    .failure(.noNetwork)
                }
            }
        )
    }
    
    static var emptyValue: StockClient {
        .init(
            getStocks: {
                AsyncStream { 
                    return .success(nil)
                }
            }
        )
    }
    
    static var decodeErrorValue: StockClient {
        .init(
            getStocks: {
                AsyncStream {
                    return .failure(.dataConversionFailed)
                }
            }
        )
    }
}

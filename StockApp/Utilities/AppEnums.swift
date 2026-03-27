//
//  AppEnums.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//
import SwiftUI
import BMSwiftNetworking

enum ViewState: Equatable {
    case loading
    case overlayLoading(Color = .white)
    case loaded
    case noNetwork
    case customState(CustomError)
    case noData
    case serverError(String)
    case searchError
    case unExpectedError(String)
    case unauthorized
    
    
    static func failHandler(_ apiError: APIError) -> Self {
        switch apiError {
        case .invalidURL:
            return .unExpectedError(Localized.errorInvalidUrl)
        case .dataConversionFailed:
            return .unExpectedError(Localized.errorDataConversionFailed)
        case .stringConversionFailed:
            return .unExpectedError(Localized.errorDataConversionFailed)
        case .httpError(let statusCode):
            switch statusCode {
            case .notAuthorize:
                return .unauthorized
            case .notFound:
                return .noData
            default:
                return .serverError(Localized.errorServerTitle)
            }
        case .noNetwork:
            return .noNetwork
        default:
            return .unExpectedError(Localized.errorUnexpectedTitle)
        }
    }
    
}

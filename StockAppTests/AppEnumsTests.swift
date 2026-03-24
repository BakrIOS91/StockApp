//
//  AppEnumsTests.swift
//  StockAppTests
//

import Testing
@testable import StockApp
import BMSwiftNetworking

@Suite("AppEnums Tests")
@MainActor
struct AppEnumsTests {
    
    @Test("Fail handler maps generic API errors properly to ViewState")
    func testFailHandlerMapping() {
        #expect(ViewState.failHandler(.invalidURL) == .unExpectedError(Localized.errorInvalidUrl))
        #expect(ViewState.failHandler(.noNetwork) == .noNetwork)
        #expect(ViewState.failHandler(.dataConversionFailed) == .unExpectedError(Localized.errorDataConversionFailed))
        #expect(ViewState.failHandler(.stringConversionFailed) == .unExpectedError(Localized.errorDataConversionFailed))
    }
    
    @Test("Fail handler maps HTTP errors properly to ViewState")
    func testFailHandlerHTTPMapping() {
        // We know .notAuthorize maps to .unauthorized
        #expect(ViewState.failHandler(.httpError(statusCode: .notAuthorize)) == .unauthorized)
        
        // We know .notFound maps to .noData
        #expect(ViewState.failHandler(.httpError(statusCode: .notFound)) == .noData)
        
        // Any other HTTP code like serverError / requestTimeout maps to serverError
        #expect(ViewState.failHandler(.httpError(statusCode: .serverError)) == .serverError(Localized.errorServerTitle))
    }
}

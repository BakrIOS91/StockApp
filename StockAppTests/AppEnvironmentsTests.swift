//
//  AppEnvironmentsTests.swift
//  StockAppTests
//

import Testing
@testable import StockApp

@Suite("AppEnvironments Tests")
struct AppEnvironmentsTests {

    @Test("AppEnvironments successfully decodes obfuscated API values")
    func testAppEnvironmentsDecoding() {
        let host = AppEnvironments.apiHost
        let key = AppEnvironments.apiKey
        
        #expect(host == "yh-finance.p.rapidapi.com", "API Host should decode correctly from obfuscated bytes")
        #expect(key == "3de6cff40cmsh19cc87a0bd3ad68p1f0310jsn816861f8051d", "API Key should decode correctly from obfuscated bytes")
    }
}

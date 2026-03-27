import Testing
import Foundation
@testable import StockApp

@Suite("StockDetails Decoding Tests")
struct StockDetailsTests {
    
    @Test("Decoding StockDetails from sample JSON")
    func testDecodingStockDetails() throws {
        let json = """
        {
            "quoteResponse": {
                "result": [
                    {
                        "language": "en-US",
                        "region": "US",
                        "quoteType": "FUTURE",
                        "typeDisp": "Futures",
                        "quoteSourceName": "Delayed Quote",
                        "triggerable": false,
                        "customPriceAlertConfidence": "NONE",
                        "quoteSummary": {
                            "summaryDetail": {
                                "maxAge": 1,
                                "priceHint": 2,
                                "previousClose": 6525.0,
                                "open": 6536.0,
                                "dayLow": 6489.25,
                                "dayHigh": 6568.5,
                                "regularMarketPreviousClose": 6525.0,
                                "regularMarketOpen": 6536.0,
                                "regularMarketDayLow": 6489.25,
                                "regularMarketDayHigh": 6568.5,
                                "volume": 210319,
                                "regularMarketVolume": 210319,
                                "averageVolume": 1565211,
                                "averageVolume10days": 1629773,
                                "averageDailyVolume10Day": 1629773,
                                "bid": 6499.5,
                                "ask": 6499.75,
                                "bidSize": 0,
                                "askSize": 100,
                                "expireDate": 1781740800,
                                "openInterest": 1886124,
                                "fiftyTwoWeekLow": 4832.0,
                                "fiftyTwoWeekHigh": 7043.0,
                                "allTimeHigh": 7043.0,
                                "allTimeLow": 665.75,
                                "fiftyDayAverage": 6852.1724,
                                "twoHundredDayAverage": 6670.9834,
                                "currency": "USD",
                                "fromCurrency": null,
                                "toCurrency": null,
                                "lastMarket": null,
                                "coinMarketCapLink": null,
                                "algorithm": null,
                                "tradeable": false
                            }
                        },
                        "contractSymbol": false,
                        "headSymbolAsString": "ES=F",
                        "currency": "USD",
                        "hasPrePostMarketData": false,
                        "firstTradeDateMilliseconds": 969249600000,
                        "priceHint": 2,
                        "regularMarketChange": -25.5,
                        "regularMarketChangePercent": -0.3908046,
                        "regularMarketTime": 1774611723,
                        "regularMarketPrice": 6499.5,
                        "regularMarketDayHigh": 6568.5,
                        "regularMarketDayRange": "6489.25 - 6568.5",
                        "regularMarketDayLow": 6489.25,
                        "regularMarketVolume": 210319,
                        "regularMarketPreviousClose": 6525.0,
                        "bid": 6499.5,
                        "ask": 6499.75,
                        "bidSize": 0,
                        "askSize": 1,
                        "exchange": "CME",
                        "market": "us24_market",
                        "fullExchangeName": "CME",
                        "shortName": "E-Mini S&P 500 Jun 26",
                        "regularMarketOpen": 6536.0,
                        "averageDailyVolume3Month": 1565211,
                        "averageDailyVolume10Day": 1629773,
                        "fiftyTwoWeekLowChange": 1667.5,
                        "fiftyTwoWeekLowChangePercent": 0.3450952,
                        "fiftyTwoWeekRange": "4832.0 - 7043.0",
                        "fiftyTwoWeekHighChange": -543.5,
                        "fiftyTwoWeekHighChangePercent": -0.07716882,
                        "fiftyTwoWeekLow": 4832.0,
                        "fiftyTwoWeekHigh": 7043.0,
                        "marketState": "REGULAR",
                        "underlyingSymbol": "ESM26.CME",
                        "underlyingExchangeSymbol": "ESM26.CME",
                        "openInterest": 1886124,
                        "expireDate": 1781740800,
                        "expireIsoDate": "2026-06-18T00:00:00Z",
                        "fiftyDayAverage": 6852.1724,
                        "fiftyDayAverageChange": -352.67236,
                        "fiftyDayAverageChangePercent": -0.051468693,
                        "twoHundredDayAverage": 6670.9834,
                        "twoHundredDayAverageChange": -171.4834,
                        "twoHundredDayAverageChangePercent": -0.025705865,
                        "sourceInterval": 10,
                        "exchangeDataDelayedBy": 10,
                        "exchangeTimezoneName": "America/New_York",
                        "exchangeTimezoneShortName": "EDT",
                        "gmtOffSetMilliseconds": -14400000,
                        "esgPopulated": false,
                        "tradeable": false,
                        "cryptoTradeable": false,
                        "symbol": "ES=F"
                    }
                ],
                "error": null
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(StockDetailsResponse.self, from: json)
            #expect(response.quoteResponse?.details?.count == 1)
            let details = response.quoteResponse?.details?.first
            #expect(details?.symbol == "ES=F")
            #expect(details?.quoteSummary?.summaryDetail?.dayHigh == 6568.5)
        } catch {
            Issue.record("Decoding failed with error: \(error)")
        }
    }
}

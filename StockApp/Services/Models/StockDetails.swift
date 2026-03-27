//
//  StockDetails.swift
//  StockApp
//
//  Created by Bakr Mohamed on 27/03/2026.
//

import Foundation

// MARK: - StockDetails Response
struct StockDetailsResponse: Codable {
    let quoteResponse: QuoteResponse?
    
    static var mock: StockDetailsResponse {
        return StockDetailsResponse(quoteResponse: .mock)
    }
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let details: [StockDetails]?
    
    enum CodingKeys: String, CodingKey {
        case details = "result"
    }
    
    static var mock: QuoteResponse {
        return QuoteResponse(details: [.mock])
    }
}

// MARK: - Detail
struct StockDetails: Codable {
    let language, region, quoteType, typeDisp: String?
    let quoteSourceName: String?
    let triggerable: Bool?
    let customPriceAlertConfidence: String?
    let quoteSummary: QuoteSummary?
    let components: [String]?
    let currency: String?
    let priceHint, totalCash, floatShares, ebitda: Int?
    let shortRatio, preMarketChange, preMarketChangePercent: Double?
    let preMarketTime, targetPriceHigh, targetPriceLow: Int?
    let targetPriceMean: Double?
    let targetPriceMedian: Int?
    let preMarketPrice, heldPercentInsiders, heldPercentInstitutions, postMarketChangePercent: Double?
    let postMarketTime: Int?
    let postMarketPrice, postMarketChange, regularMarketChange, regularMarketChangePercent: Double?
    let regularMarketTime: Int?
    let regularMarketPrice: Double?
    let regularMarketDayHigh: Double?
    let regularMarketDayRange: String?
    let regularMarketDayLow: Double?
    let regularMarketVolume, sharesShort, sharesShortPrevMonth: Int?
    let shortPercentFloat, regularMarketPreviousClose, bid, ask: Double?
    let bidSize, askSize: Int?
    let exchange, market, messageBoardID, fullExchangeName: String?
    let shortName, longName, financialCurrency: String?
    let regularMarketOpen: Double?
    let averageDailyVolume3Month, averageDailyVolume10Day: Int?
    let beta, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double?
    let fiftyTwoWeekRange: String?
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh: Double?
    let openInterest: Int?
    let expireDate: Int?
    let expireIsoDate: String?
    let underlyingSymbol, underlyingExchangeSymbol: String?
    let dividendDate, exDividendDate, earningsTimestamp, earningsTimestampStart: Int?
    let earningsTimestampEnd: Int?
    let trailingAnnualDividendRate, trailingPE, dividendsPerShare, dividendRate: Double?
    let trailingAnnualDividendYield, dividendYield: Double?
    let revenue: Int?
    let priceToSales: Double?
    let marketState: String?
    let epsTrailingTwelveMonths, epsForward, epsCurrentYear, epsNextQuarter: Double?
    let priceEpsCurrentYear, priceEpsNextQuarter: Double?
    let sharesOutstanding: Int?
    let bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent: Double?
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double?
    let marketCap: Int?
    let forwardPE, priceToBook: Double?
    let sourceInterval, exchangeDataDelayedBy: Int?
    let exchangeTimezoneName, exchangeTimezoneShortName: String?
    let pageViews: PageViews?
    let gmtOffSetMilliseconds: Int?
    let esgPopulated, tradeable, cryptoTradeable, hasPrePostMarketData: Bool?
    let firstTradeDateMilliseconds: Int?
    let symbol: String?

    enum CodingKeys: String, CodingKey {
        case language, region, quoteType, typeDisp, quoteSourceName, triggerable, customPriceAlertConfidence, quoteSummary, components, currency, priceHint, totalCash, floatShares, ebitda, shortRatio, preMarketChange, preMarketChangePercent, preMarketTime, targetPriceHigh, targetPriceLow, targetPriceMean, targetPriceMedian, preMarketPrice, heldPercentInsiders, heldPercentInstitutions, postMarketChangePercent, postMarketTime, postMarketPrice, postMarketChange, regularMarketChange, regularMarketChangePercent, regularMarketTime, regularMarketPrice, regularMarketDayHigh, regularMarketDayRange, regularMarketDayLow, regularMarketVolume, sharesShort, sharesShortPrevMonth, shortPercentFloat, regularMarketPreviousClose, bid, ask, bidSize, askSize, exchange, market
        case messageBoardID = "messageBoardId"
        case fullExchangeName, shortName, longName, financialCurrency, regularMarketOpen, averageDailyVolume3Month, averageDailyVolume10Day, beta, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange, fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow, fiftyTwoWeekHigh, dividendDate, exDividendDate, earningsTimestamp, earningsTimestampStart, earningsTimestampEnd, trailingAnnualDividendRate, trailingPE, dividendsPerShare, dividendRate, trailingAnnualDividendYield, dividendYield, revenue, priceToSales, marketState, epsTrailingTwelveMonths, epsForward, epsCurrentYear, epsNextQuarter, priceEpsCurrentYear, priceEpsNextQuarter, sharesOutstanding, bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent, twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent, marketCap, forwardPE, priceToBook, sourceInterval, exchangeDataDelayedBy, exchangeTimezoneName, exchangeTimezoneShortName, pageViews, gmtOffSetMilliseconds, esgPopulated, tradeable, cryptoTradeable, hasPrePostMarketData, firstTradeDateMilliseconds, symbol, openInterest, expireDate, expireIsoDate, underlyingSymbol, underlyingExchangeSymbol
    }
}

// MARK: - PageViews
struct PageViews: Codable {
    let midTermTrend, longTermTrend, shortTermTrend: String?
}

// MARK: - QuoteSummary
struct QuoteSummary: Codable {
    let summaryDetail: SummaryDetail?
    let earnings: Earnings?
}

// MARK: - Earnings
struct Earnings: Codable {
    let maxAge: Int?
    let earningsChart: EarningsChart?
    let financialsChart: FinancialsChart?
    let financialCurrency, defaultMethodology: String?
}

// MARK: - EarningsChart
struct EarningsChart: Codable {
    let quarterly: [EarningsChartQuarterly]?
    let currentQuarterEstimate: Double?
    let currentQuarterEstimateDate, currentCalendarQuarter: String?
    let currentQuarterEstimateYear: Int?
    let currentFiscalQuarter: String?
    let currentPeriodEndDate: Int?
    let earningsDate: [Int]?
    let isEarningsDateEstimate: Bool?
}

// MARK: - EarningsChartQuarterly
struct EarningsChartQuarterly: Codable {
    let date: String?
    let actual, estimate: Double?
    let fiscalQuarter, calendarQuarter, difference, surprisePct: String?
    let periodEndDate, reportedDate: Int?
}

// MARK: - FinancialsChart
struct FinancialsChart: Codable {
    let yearly: [Yearly]?
    let quarterly: [FinancialsChartQuarterly]?
}

// MARK: - FinancialsChartQuarterly
struct FinancialsChartQuarterly: Codable {
    let date, fiscalQuarter: String?
    let revenue, earnings: Int?
}

// MARK: - Yearly
struct Yearly: Codable, Identifiable {
    let date, revenue, earnings: Int?
    
    var id: Int { date ?? UUID().hashValue }
}

// MARK: - SummaryDetail
struct SummaryDetail: Codable {
    let maxAge, priceHint: Int?
    let previousClose, summaryDetailOpen, dayLow: Double?
    let dayHigh: Double?
    let regularMarketPreviousClose, regularMarketOpen, regularMarketDayLow: Double?
    let regularMarketDayHigh: Double?
    let expireDate, openInterest: Int?
    let dividendRate, dividendYield: Double?
    let exDividendDate: Int?
    let payoutRatio, fiveYearAvgDividendYield, beta, trailingPE: Double?
    let forwardPE: Double?
    let volume, regularMarketVolume, averageVolume, averageVolume10Days: Int?
    let averageDailyVolume10Day: Int?
    let bid, ask: Double?
    let bidSize, askSize, marketCap, nonDilutedMarketCap: Int?
    let fiftyTwoWeekLow, fiftyTwoWeekHigh, allTimeHigh, allTimeLow: Double?
    let priceToSalesTrailing12Months, fiftyDayAverage, twoHundredDayAverage, trailingAnnualDividendRate: Double?
    let trailingAnnualDividendYield: Double?
    let currency: String?
    let fromCurrency, toCurrency, lastMarket, coinMarketCapLink: String?
    let algorithm: String?
    let tradeable: Bool?

    enum CodingKeys: String, CodingKey {
        case maxAge, priceHint, previousClose
        case summaryDetailOpen = "open"
        case dayLow, dayHigh, regularMarketPreviousClose, regularMarketOpen, regularMarketDayLow, regularMarketDayHigh, dividendRate, dividendYield, exDividendDate, payoutRatio, fiveYearAvgDividendYield, beta, trailingPE, forwardPE, volume, regularMarketVolume, averageVolume
        case averageVolume10Days = "averageVolume10days"
        case averageDailyVolume10Day, bid, ask, bidSize, askSize, marketCap, nonDilutedMarketCap, fiftyTwoWeekLow, fiftyTwoWeekHigh, allTimeHigh, allTimeLow, priceToSalesTrailing12Months, fiftyDayAverage, twoHundredDayAverage, trailingAnnualDividendRate, trailingAnnualDividendYield, currency, fromCurrency, toCurrency, lastMarket, coinMarketCapLink, algorithm, tradeable, expireDate, openInterest
    }
}

extension StockDetails {
    static var mock: StockDetails {
        StockDetails(
            language: "en",
            region: "US",
            quoteType: "EQUITY",
            typeDisp: "Equity",
            quoteSourceName: "Nasdaq Real Time Price",
            triggerable: true,
            customPriceAlertConfidence: nil,
            quoteSummary: nil,
            components: nil,
            currency: "USD",
            priceHint: 2,
            totalCash: nil,
            floatShares: nil,
            ebitda: nil,
            shortRatio: nil,
            preMarketChange: nil,
            preMarketChangePercent: nil,
            preMarketTime: nil,
            targetPriceHigh: nil,
            targetPriceLow: nil,
            targetPriceMean: nil,
            targetPriceMedian: nil,
            preMarketPrice: nil,
            heldPercentInsiders: nil,
            heldPercentInstitutions: nil,
            postMarketChangePercent: nil,
            postMarketTime: nil,
            postMarketPrice: nil,
            postMarketChange: nil,
            regularMarketChange: 0.27,
            regularMarketChangePercent: 0.107,
            regularMarketTime: nil,
            regularMarketPrice: 252.89,
            regularMarketDayHigh: 257,
            regularMarketDayRange: "250.775 - 257",
            regularMarketDayLow: 250.775,
            regularMarketVolume: nil,
            sharesShort: nil,
            sharesShortPrevMonth: nil,
            shortPercentFloat: nil,
            regularMarketPreviousClose: 252.62,
            bid: 252.8,
            ask: 253.21,
            bidSize: nil,
            askSize: nil,
            exchange: "NMS",
            market: nil,
            messageBoardID: nil,
            fullExchangeName: nil,
            shortName: "Apple Inc.",
            longName: "Apple Inc.",
            financialCurrency: nil,
            regularMarketOpen: 251.995,
            averageDailyVolume3Month: nil,
            averageDailyVolume10Day: nil,
            beta: nil,
            fiftyTwoWeekLowChange: nil,
            fiftyTwoWeekLowChangePercent: nil,
            fiftyTwoWeekRange: "169.21 - 288.62",
            fiftyTwoWeekHighChange: nil,
            fiftyTwoWeekHighChangePercent: nil,
            fiftyTwoWeekLow: 169.21,
            fiftyTwoWeekHigh: 288.62,
            openInterest: nil,
            expireDate: nil,
            expireIsoDate: nil,
            underlyingSymbol: nil,
            underlyingExchangeSymbol: nil,
            dividendDate: nil,
            exDividendDate: nil,
            earningsTimestamp: nil,
            earningsTimestampStart: nil,
            earningsTimestampEnd: nil,
            trailingAnnualDividendRate: nil,
            trailingPE: 32.05,
            dividendsPerShare: nil,
            dividendRate: 1.04,
            trailingAnnualDividendYield: nil,
            dividendYield: 0.41,
            revenue: nil,
            priceToSales: nil,
            marketState: "PRE",
            epsTrailingTwelveMonths: 7.89,
            epsForward: 9.315,
            epsCurrentYear: nil,
            epsNextQuarter: nil,
            priceEpsCurrentYear: nil,
            priceEpsNextQuarter: nil,
            sharesOutstanding: 14_681_140_000,
            bookValue: nil,
            fiftyDayAverage: 260.5086,
            fiftyDayAverageChange: nil,
            fiftyDayAverageChangePercent: nil,
            twoHundredDayAverage: 247.82214,
            twoHundredDayAverageChange: nil,
            twoHundredDayAverageChangePercent: nil,
            marketCap: 3_716_958_388_224,
            forwardPE: 27.15,
            priceToBook: nil,
            sourceInterval: nil,
            exchangeDataDelayedBy: nil,
            exchangeTimezoneName: nil,
            exchangeTimezoneShortName: nil,
            pageViews: PageViews(
                midTermTrend: "UP",
                longTermTrend: "UP",
                shortTermTrend: "UP"
            ),
            gmtOffSetMilliseconds: nil,
            esgPopulated: nil,
            tradeable: true,
            cryptoTradeable: nil,
            hasPrePostMarketData: nil,
            firstTradeDateMilliseconds: nil,
            symbol: "AAPL"
        )
    }
}

import Foundation

enum Localized {
    static let errorInvalidUrl = String(localized: "error_invalid_url")
    static let errorDataConversionFailed = String(localized: "error_data_conversion_failed")
    
    static let errorNoNetworkTitle = String(localized: "error_no_network_title")
    static let errorNoNetworkDescription = String(localized: "error_no_network_description")
    
    static let commonTryAgain = String(localized: "common_try_again")
    
    static let errorNoDataTitle = String(localized: "error_no_data_title")
    static let errorNoDataDescription = String(localized: "error_no_data_description")
    
    static let errorServerTitle = String(localized: "error_server_title")
    static let errorServerDescription = String(localized: "error_server_description")
    
    static let errorSearchTitle = String(localized: "error_search_title")
    static let errorSearchDescription = String(localized: "error_search_description")
    
    static let errorUnexpectedTitle = String(localized: "error_unexpected_title")
    static let errorUnexpectedDescription = String(localized: "error_unexpected_description")
    
    static let stockTitle = String(localized: "stock_title")
    static let totalInvestmentTitle = String(localized: "total_investment_title")
    static let searchPlaceholder = String(localized: "search_placeholder")
    
    // MARK: - Stock Details
    static let statistics = String(localized: "Statistics")
    static let marketCap = String(localized: "Market Cap")
    static let open = String(localized: "Open")
    static let prevClose = String(localized: "Prev. Close")
    static let dayRange = String(localized: "Day Range")
    static let fiftyTwoWeekRange = String(localized: "52W Range")
    static let volume = String(localized: "Volume")
    static let avgVolume3m = String(localized: "Avg Vol (3m)")
    static let peForward = String(localized: "PE (Forward)")
    static let peTrailing = String(localized: "PE (Trailing)")
    static let priceSales = String(localized: "Price/Sales")
    static let priceBook = String(localized: "Price/Book")
    static let beta = String(localized: "Beta")
    static let sharesOut = String(localized: "Shares Out.")
    static let bid = String(localized: "Bid")
    static let ask = String(localized: "Ask")
    
    static let dividends = String(localized: "Dividends")
    static let dividendRate = String(localized: "Dividend Rate")
    static let dividendYield = String(localized: "Dividend Yield")
    
    static let earnings = String(localized: "Earnings")
    static let epsTTM = String(localized: "EPS (TTM)")
    static let epsForward = String(localized: "EPS (Forward)")
    static let quarterlyEstimates = String(localized: "Quarterly Estimates")
    
    static let financials = String(localized: "Financials")
    
    static func actLabel(_ value: String) -> String { String(localized: "Act: \(value)") }
    static func estLabel(_ value: String) -> String { String(localized: "Est: \(value)") }
    static func revLabel(_ value: String) -> String { String(localized: "Rev: \(value)") }
    static func earnLabel(_ value: String) -> String { String(localized: "Earn: \(value)") }
    
    static let preMarketLabel = String(localized: "Pre-Market:")
    static let na = String(localized: "n/a")
}

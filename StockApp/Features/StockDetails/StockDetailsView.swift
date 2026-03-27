//
//  StockDetailsView.swift
//  StockApp
//

import SwiftUI
import BMSwiftUI

struct StockDetailsView: View {
    
    @State var viewModel: StockDetailsViewModel
    
    var body: some View {
        ZStack {
            Color.appMainBackground.ignoresSafeArea()
            
            WithViewState(viewState: $viewModel.state.viewState) {
                Unwrap(viewModel.state.details) { details in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            headerSection(details)
                            
                            priceCard(details)
                            
                            statsGrid(details)
                            
                            if details.dividendRate != nil || details.dividendYield != nil {
                                infoCard(title: Localized.dividends) {
                                    dividendContent(details)
                                }
                            }
                            
                            if details.quoteSummary?.earnings != nil {
                                infoCard(title: Localized.earnings) {
                                    earningsContent(details)
                                }
                            }
                            
                            if let yearly = details.quoteSummary?.earnings?.financialsChart?.yearly, !yearly.isEmpty {
                                infoCard(title: Localized.financials) {
                                    financialsContent(yearly)
                                }
                            }
                        }
                        .setPadding()
                    }
                }
            } retryAction: {
                viewModel.trigger(.fetchStockDetails)
            }
        }
        .navigationTitle(viewModel.state.stockName)
        .toolbarTitleDisplayMode(.inline)
        .task {
            viewModel.trigger(.fetchStockDetails)
        }
    }
}

// MARK: - Components
private extension StockDetailsView {
    
    func infoCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringKey(title))
                .textStyle(weight: .bold, size: 18, color: .appTextColor)
            
            content()
        }
        .setPadding()
        .background(Color.appWhite)
        .setCornerRadius(16)
        .shadow(color: .shadowColor, radius: 10, x: 0, y: 5)
    }
    
    func statRow(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(LocalizedStringKey(label))
                .textStyle(weight: .medium, size: 12, color: .appSecondaryText)
            Text(value)
                .textStyle(weight: .bold, size: 14, color: .appTextColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Header
private extension StockDetailsView {
    
    func headerSection(_ details: StockDetails) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .lastTextBaseline, spacing: 8) {
                Text(details.symbol ?? "n/a")
                    .textStyle(weight: .black, size: 36, color: .appTextColor)
                
                Text(details.fullExchangeName ?? details.exchange ?? "")
                    .textStyle(weight: .medium, size: 14, color: .appSecondaryText)
            }
            
            Text(details.longName ?? details.shortName ?? "")
                .textStyle(weight: .medium, size: 18, color: .appSecondaryText)
            
            HStack(spacing: 8) {
                Circle()
                    .fill(details.marketState == "REGULAR" ? Color.appPrimaryColor : Color.appOrangeColor)
                    .frame(width: 8, height: 8)
                
                Text(details.marketState?.replacingOccurrences(of: "_", with: " ").capitalized ?? "")
                    .textStyle(weight: .bold, size: 12, color: details.marketState == "REGULAR" ? .appPrimaryColor : .appOrangeColor)
                
                if let region = details.region {
                    Text("•")
                        .textStyle(weight: .regular, size: 12, color: .appSecondaryText)
                    Text(region)
                        .textStyle(weight: .bold, size: 12, color: .appSecondaryText)
                }
            }
            .padding(.top, 4)
        }
    }
}

// MARK: - Price Card
private extension StockDetailsView {
    
    func priceCard(_ details: StockDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Text(details.currency ?? "USD")
                    .textStyle(weight: .bold, size: 16, color: .appSecondaryText)
                
                Text("\(details.regularMarketPrice ?? 0, specifier: "%.2f")")
                    .textStyle(weight: .black, size: 30, color: .appTextColor)
                
                Spacer()
                
                let change = details.regularMarketChange ?? 0
                let percent = (details.regularMarketChangePercent ?? 0) * 100
                let isPositive = change >= 0
                
                HStack(spacing: 4) {
                    Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    Text("\(abs(change), specifier: "%.2f") (\(abs(percent), specifier: "%.2f")%)")
                }
                .textStyle(weight: .bold, size: 16, color: .white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isPositive ? Color.appPrimaryColor : Color.reddishBrown)
                .setCornerRadius(8)
            }
            
            if let pre = details.preMarketPrice, details.marketState != "REGULAR" {
                HStack {
                    Text(Localized.preMarketLabel)
                        .textStyle(weight: .medium, size: 14, color: .appSecondaryText)
                    Text("\(pre, specifier: "%.2f")")
                        .textStyle(weight: .bold, size: 14, color: .appTextColor)
                    Text("(\(details.preMarketChange ?? 0, specifier: "%.2f"))")
                        .textStyle(weight: .medium, size: 14, color: (details.preMarketChange ?? 0) >= 0 ? .appPrimaryColor : .reddishBrown)
                }
                .padding(.top, -8)
            }
        }
        .setPadding()
        .background(Color.appWhite)
        .setCornerRadius(16)
        .shadow(color: .shadowColor, radius: 10, x: 0, y: 5)
    }
}

// MARK: - Stats Grid
private extension StockDetailsView {
    
    func statsGrid(_ details: StockDetails) -> some View {
        infoCard(title: Localized.statistics) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                statRow(label: Localized.marketCap, value: details.marketCap?.formattedWithSeparator ?? Localized.na)
                statRow(label: Localized.open, value: String(format: "%.2f", details.regularMarketOpen ?? 0))
                statRow(label: Localized.prevClose, value: String(format: "%.2f", details.regularMarketPreviousClose ?? 0))
                statRow(label: Localized.dayRange, value: details.regularMarketDayRange ?? Localized.na)
                statRow(label: Localized.fiftyTwoWeekRange, value: details.fiftyTwoWeekRange ?? Localized.na)
                statRow(label: Localized.volume, value: details.regularMarketVolume?.formattedWithSeparator ?? Localized.na)
                statRow(label: Localized.avgVolume3m, value: details.averageDailyVolume3Month?.formattedWithSeparator ?? Localized.na)
                statRow(label: Localized.peForward, value: String(format: "%.2f", details.forwardPE ?? 0))
                statRow(label: Localized.peTrailing, value: String(format: "%.2f", details.trailingPE ?? 0))
                statRow(label: Localized.priceSales, value: String(format: "%.2f", details.priceToSales ?? 0))
                statRow(label: Localized.priceBook, value: String(format: "%.2f", details.priceToBook ?? 0))
                statRow(label: Localized.beta, value: String(format: "%.2f", details.beta ?? 0))
                statRow(label: Localized.sharesOut, value: details.sharesOutstanding?.formattedWithSeparator ?? Localized.na)
                
                if let bid = details.bid {
                    statRow(label: Localized.bid, value: "\(String(format: "%.2f", bid)) x \(details.bidSize ?? 0)")
                }
                
                if let ask = details.ask {
                    statRow(label: Localized.ask, value: "\(String(format: "%.2f", ask)) x \(details.askSize ?? 0)")
                }
            }
        }
    }
}

// MARK: - Section Contents
private extension StockDetailsView {
    
    func dividendContent(_ details: StockDetails) -> some View {
        HStack {
            statRow(label: Localized.dividendRate, value: String(format: "%.2f", details.dividendRate ?? 0))
            statRow(label: Localized.dividendYield, value: String(format: "%.2f%%", (details.dividendYield ?? 0)))
        }
    }
    
    func earningsContent(_ details: StockDetails) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                statRow(label: Localized.epsTTM, value: details.epsTrailingTwelveMonths.formattedWithSeparator)
                statRow(label: Localized.epsForward, value: details.epsForward.formattedWithSeparator)
            }
            
            if let quarterly = details.quoteSummary?.earnings?.earningsChart?.quarterly {
                VStack(alignment: .leading, spacing: 8) {
                    Text(Localized.quarterlyEstimates)
                        .textStyle(weight: .bold, size: 14, color: .appTextColor)
                    
                    ForEach(quarterly, id: \.date) { q in
                        HStack {
                            Text(q.date ?? Localized.na)
                                .textStyle(weight: .medium, size: 13, color: .appSecondaryText)
                            Spacer()
                            Text(Localized.actLabel(q.actual.formattedWithSeparator))
                                .textStyle(weight: .bold, size: 13, color: .appTextColor)
                            Text(Localized.estLabel(q.estimate.formattedWithSeparator))
                                .textStyle(weight: .medium, size: 13, color: .appSecondaryText)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
    }
    
    func financialsContent(_ yearly: [Yearly]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(yearly) { year in
                HStack {
                    Text("\(year.date ?? 0)")
                        .textStyle(weight: .bold, size: 14, color: .appTextColor)
                        .frame(width: 50, alignment: .leading)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(Localized.revLabel(year.revenue?.formattedWithSeparator ?? Localized.na))
                            .textStyle(weight: .medium, size: 13, color: .appSecondaryText)
                        Text(Localized.earnLabel(year.earnings?.formattedWithSeparator ?? Localized.na))
                            .textStyle(weight: .bold, size: 13, color: .appTextColor)
                    }
                }
                if year.id != yearly.last?.id {
                    Divider()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StockDetailsView(viewModel: .init(symbol: "AAPL", stockName: "Apple"))
    }
}

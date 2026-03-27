//
//  StockListView.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftUI

struct StockListView: View {
    @Bindable var viewModel: StockListViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                
                stockListSection
            }
            .ignoresSafeArea()
            .task {
                viewModel.trigger(.fetchStocks)
            }
            .navigationDestination(item: $viewModel.state.stockDetailsViewModel) {
                StockDetailsView(viewModel: $0)
            }
        }
    }
}

// MARK: - Sections
private extension StockListView {
    var headerSection: some View {
        ZStack {
            Color.appMainColor
            
            VStack(spacing: 20) {
                Text(Localized.totalInvestmentTitle)
                    .textStyle(
                        weight: .regular,
                        size: 16,
                        color: .appWhite
                    )
                
                Text("$100,000.00")
                    .textStyle(
                        weight: .bold,
                        size: 24,
                        color: .appWhite
                    )
            }
        }
        .setFrame(height: 200)
        .setCornerRadius(50, corners: [.bottomLeft, .bottomRight])
    }
    
    var stockListSection: some View {
        VStack(alignment:.leading){
            Text(Localized.stockTitle)
                .textStyle(
                    weight: .bold,
                    size: 24,
                    color: .appBlack
                )
            
            WithViewState(viewState: $viewModel.state.viewState,isRefreshable: true) {
                VStack(spacing: 20){
                    SearchBar(
                        text: $viewModel.state.searchText,
                        placeholder: Localized.searchPlaceholder
                    ) { newValue in
                        viewModel.trigger(.searchChanged(newValue))
                    }
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20){
                            ForEach(viewModel.state.filteredStocks) { stock in
                                self.cellFor(stock)
                            }
                        }
                    }
                }
            } retryAction: {
                viewModel.trigger(.fetchStocks)
            }
        }
        .setPadding([.horizontal, .bottom], 20)
    }
}

// MARK: - Components
private extension StockListView {
    func cellFor(_ stock: StockListem) -> some View {
        Button {
            viewModel.trigger(.didPressOnStock(stock))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(stock.stockName)
                        .textStyle(
                            weight: .medium,
                            size: 20,
                            color: .appBlack
                        )
                    
                    Text(stock.symbol ?? "N/A")
                        .textStyle(
                            weight: .regular,
                            size: 18,
                            color: .appGrayColor
                        )
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text("\(stock.price)$")
                        .textStyle(
                            weight: .medium,
                            size: 18,
                            color: .black
                        )
                    
                    Text("\(stock.statusSymbol) \(stock.changePercent, specifier: "%.1f")%")
                        .textStyle(
                            weight: .regular,
                            size: 14,
                            color: Color(hex: stock.statusColorHex)
                        )
                }
                
            }
        }
    }
}

// MARK: - Preview
#Preview {
    StockListView(
        viewModel: .init()
    )
}

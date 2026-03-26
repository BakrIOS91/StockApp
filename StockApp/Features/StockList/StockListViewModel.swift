//
//  StockListViewModel.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import Foundation
import BMSwiftUI
import BMSwiftNetworking

@Observable
final class StockListViewModel: BaseViewModel<StockListViewModel.State, StockListViewModel.Action> {
    
    @ObservationIgnored
    @Injected(\.stockClient) var stockClient: StockClient
    
    struct State {
        var viewState: ViewState = .loading
        var stocks: [StockListem] = []
        var searchText: String = ""
        var filteredStocks: [StockListem] = []
        var selectedStock: StockListem?
    }
    
    enum Action {
        case fetchStocks
        case stockListResponse(AsyncStream<Result<StockList?, APIError>>)
        case searchChanged(String)
        case didPressOnStock(StockListem)
    }
    
    init(){
        super.init(state: .init())
    }
    
    override func onTrigger(_ action: Action) -> ViewModelEffect {
        switch action {
        case .fetchStocks:
            state.viewState = .loading
            return .task { [weak self] in
                guard let self else { return }
                let stream = await self.stockClient.getStocks()
                self.trigger(.stockListResponse(stream))
            }
            
        case .stockListResponse(let stream):
            return .task { [weak self] in
                guard let self else { return }
                for await result in stream {
                    switch result {
                    case .success(let response):
                        if let stocks = response?.marketSummaryAndSparkResponse?.result, !stocks.isEmpty {
                            self.state.stocks = stocks
                            self.state.viewState = .loaded
                            self.trigger(.searchChanged(self.state.searchText))
                        } else {
                            self.state.viewState = .noData
                        }
                    case .failure(let error):
                        self.state.viewState = .failHandler(error)
                    }
                }
            }
            
        case .searchChanged(let text):
            state.searchText = text
            if text.isEmpty {
                state.filteredStocks = state.stocks
            } else {
                state.filteredStocks = state.stocks.filter {
                    ($0.symbol?.localizedCaseInsensitiveContains(text) == true) ||
                    ($0.fullExchangeName?.localizedCaseInsensitiveContains(text) == true)
                }
            }
            return .none
        case .didPressOnStock(let stock):
            state.selectedStock = stock
            return .none
        }
    }
}

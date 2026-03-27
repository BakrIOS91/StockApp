//
//  StockDetailsViewModel.swift
//  StockApp
//
//  Created by Bakr Mohamed on 27/03/2026.
//

import Foundation
import BMSwiftUI
import BMSwiftNetworking

@Observable
final class StockDetailsViewModel: BaseViewModel<StockDetailsViewModel.State, StockDetailsViewModel.Action> {
    
    @ObservationIgnored
    @Injected(\.stockClient) var stockClient: StockClient
    
    struct State {
        var symbol: String
        var stockName: String
        var viewState: ViewState = .loading
        var details: StockDetails?
    }
    
    enum Action {
        case fetchStockDetails
        case stockDetailsResponse(Result<StockDetailsResponse?, APIError>)
    }
    
    init(symbol: String, stockName: String){
        super.init(state: .init(symbol: symbol,stockName: stockName))
    }
    
    override func onTrigger(_ action: Action) -> ViewModelEffect {
        switch action {
        case .fetchStockDetails:
            state.viewState = .loading
            return .task { [weak self] in
                guard let self else { return }
                let result = await self.stockClient.getStockDetails(state.symbol)
                self.trigger(.stockDetailsResponse(result))
            }
            
        case .stockDetailsResponse(let result):
            switch result {
            case .success(let response):
                if let details = response?.quoteResponse?.details?.first {
                    state.details = details
                    state.viewState = .loaded
                } else {
                    self.state.viewState = .noData
                }
            case .failure(let error):
                self.state.viewState = .failHandler(error)
            }
            
            return .none
        }
    }
}

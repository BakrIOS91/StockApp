//
//  StockListViewModelTests.swift
//  StockAppTests
//
//  Created by Bakr Mohamed on 26/03/2026.
//

import Testing
import Foundation
import BMSwiftUI
import BMSwiftNetworking
@testable import StockApp

@Suite("StockListViewModel Tests")
@MainActor
struct StockListViewModelTests {
    
    @Test("Initial state is loading and empty")
    func testInitialState() {
        let viewModel = StockListViewModel()
        #expect(viewModel.state.viewState == .loading)
        #expect(viewModel.state.stocks.isEmpty)
        #expect(viewModel.state.searchText == "")
    }
    
    @Test("Fetching stocks success updates state")
    func testFetchStocksSuccess() async {
        let mockStocks = StockListem.mock
        
        await DependencyValues.withDependencies {
            $0.stockClient = .init(getStocks: {
                AsyncStream { continuation in
                    continuation.yield(.success(StockList(marketSummaryAndSparkResponse: .init(result: mockStocks, error: nil))))
                    continuation.finish()
                }
            })
        } operation: {
            let viewModel = StockListViewModel()
            viewModel.trigger(.fetchStocks)
            
            // Wait for the effect task to complete (including nested triggers)
            try? await Task.sleep(for: .milliseconds(100))
            
            #expect(viewModel.state.stocks.count == mockStocks.count)
            #expect(viewModel.state.viewState == .loaded)
            #expect(viewModel.state.filteredStocks.count == mockStocks.count)
        }
    }
    
    @Test("Searching stocks filters the list")
    func testSearchFiltering() {
        let mockStocks = StockListem.mock // Contains Apple, Microsoft, Google, Amazon, Tesla
        
        let viewModel = StockListViewModel()
        viewModel.state.stocks = mockStocks
        viewModel.state.filteredStocks = mockStocks
        
        // Search for "Apple"
        viewModel.trigger(.searchChanged("Apple"))
        #expect(viewModel.state.filteredStocks.count == 1)
        #expect(viewModel.state.filteredStocks.first?.symbol == "AAPL")
        
        // Search for "Micro"
        viewModel.trigger(.searchChanged("Micro"))
        #expect(viewModel.state.filteredStocks.count == 1)
        #expect(viewModel.state.filteredStocks.first?.symbol == "MSFT")
        
        // Empty search
        viewModel.trigger(.searchChanged(""))
        #expect(viewModel.state.filteredStocks.count == mockStocks.count)
    }
    
    @Test("Selecting a stock updates selectedStock")
    func testSelectStock() {
        let mockStock = StockListem.mock[0]
        let viewModel = StockListViewModel()
        
        viewModel.trigger(.didPressOnStock(mockStock))
        #expect(viewModel.state.selectedStock?.symbol == mockStock.symbol)
    }
    
    @Test("Fetching stocks failure updates viewState")
    func testFetchStocksFailure() async {
        await DependencyValues.withDependencies {
            $0.stockClient = .init(getStocks: {
                AsyncStream { continuation in
                    continuation.yield(.failure(.noNetwork))
                    continuation.finish()
                }
            })
        } operation: {
            let viewModel = StockListViewModel()
            viewModel.trigger(.fetchStocks)
            
            // Wait for the effect task to complete
            try? await Task.sleep(for: .milliseconds(100))
            
            #expect(viewModel.state.viewState == .noNetwork)
        }
    }
}

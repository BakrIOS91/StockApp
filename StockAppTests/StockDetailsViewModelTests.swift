//
//  StockDetailsViewModelTests.swift
//  StockAppTests
//
//  Created by Bakr Mohamed on 27/03/2026.
//

import Testing
import Foundation
import BMSwiftUI
import BMSwiftNetworking
@testable import StockApp

@Suite("StockDetailsViewModel Tests")
@MainActor
struct StockDetailsViewModelTests {
    
    @Test("Initial state is correct")
    func testInitialState() {
        let viewModel = StockDetailsViewModel(symbol: "AAPL", stockName: "Apple Inc.")
        #expect(viewModel.state.symbol == "AAPL")
        #expect(viewModel.state.stockName == "Apple Inc.")
        #expect(viewModel.state.viewState == .loading)
        #expect(viewModel.state.details == nil)
        #expect(viewModel.state.descriptionMaxLines == 3)
    }
    
    @Test("Fetching stock details success updates state")
    func testFetchStockDetailsSuccess() async {
        let mockDetails = StockDetails.mock
        
        await DependencyValues.withDependencies {
            $0.stockClient = .init(getStocks: {
                AsyncStream { _ in }
            }, getStockDetails: { symbol in
                #expect(symbol == "AAPL")
                return .success(StockDetailsResponse(quoteResponse: QuoteResponse(details: [mockDetails])))
            })
        } operation: {
            let viewModel = StockDetailsViewModel(symbol: "AAPL", stockName: "Apple Inc.")
            viewModel.trigger(.fetchStockDetails)
            
            // Wait for the effect task to complete
            try? await Task.sleep(for: .milliseconds(100))
            
            #expect(viewModel.state.details?.symbol == "AAPL")
            #expect(viewModel.state.viewState == .loaded)
        }
    }
    
    @Test("Fetching stock details failure updates viewState")
    func testFetchStockDetailsFailure() async {
        await DependencyValues.withDependencies {
            $0.stockClient = .init(getStocks: {
                AsyncStream { _ in }
            }, getStockDetails: { _ in
                return .failure(.noNetwork)
            })
        } operation: {
            let viewModel = StockDetailsViewModel(symbol: "AAPL", stockName: "Apple Inc.")
            viewModel.trigger(.fetchStockDetails)
            
            // Wait for the effect task to complete
            try? await Task.sleep(for: .milliseconds(100))
            
            #expect(viewModel.state.viewState == .noNetwork)
        }
    }
    
    @Test("Fetching stock details with empty results updates viewState to noData")
    func testFetchStockDetailsEmptyResults() async {
        await DependencyValues.withDependencies {
            $0.stockClient = .init(getStocks: {
                AsyncStream { _ in }
            }, getStockDetails: { _ in
                return .success(StockDetailsResponse(quoteResponse: QuoteResponse(details: [])))
            })
        } operation: {
            let viewModel = StockDetailsViewModel(symbol: "AAPL", stockName: "Apple Inc.")
            viewModel.trigger(.fetchStockDetails)
            
            // Wait for the effect task to complete
            try? await Task.sleep(for: .milliseconds(100))
            
            #expect(viewModel.state.viewState == .noData)
        }
    }
    
    @Test("Toggling description max lines updates the state")
    func testToggleDescriptionMaxLines() {
        let viewModel = StockDetailsViewModel(symbol: "AAPL", stockName: "Apple Inc.")
        
        // Initial state is 3
        #expect(viewModel.state.descriptionMaxLines == 3)
        
        // Toggle to 0 (unlimited)
        viewModel.trigger(.toggleDescriptionMaxLines)
        #expect(viewModel.state.descriptionMaxLines == 0)
        
        // Toggle back to 3
        viewModel.trigger(.toggleDescriptionMaxLines)
        #expect(viewModel.state.descriptionMaxLines == 3)
    }
}

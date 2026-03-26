//
//  StockAppApp.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftNetworking

@main
struct StockApp: App {
    
    init () {
        NetworkMonitor.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            StockListView(
                viewModel: .init()
            )
        }
    }
}

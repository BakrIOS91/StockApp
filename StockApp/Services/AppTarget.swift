//
//  AppTarget.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import BMSwiftNetworking

struct AppTarget: Target {
    static var shared = AppTarget()
    
    var appEnvironment: AppEnvironment = .development
    
    var kAppHost: String {
        return AppEnvironments.apiHost
    }
    
    var kMainAPIPath: String? {
        return "market/v2/"
    }
    
    var kAppScheme: String{
        return "https"
    }
}

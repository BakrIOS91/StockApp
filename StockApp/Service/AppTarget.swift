//
//  AppTarget.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import BMSwiftNetworking

final class AppTarget: Target {
    var appEnvironment: AppEnvironment = .development
    
    var kAppHost: String {
        return AppEnvironments.apiHost
    }
    
    var kAppScheme: String{
        return "https"
    }
}

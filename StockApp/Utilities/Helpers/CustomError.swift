//
//  CustomError.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI

struct CustomError: Equatable {
      
    let errorImage:Image
    let errorTitle: String
    let errorMessage: String
    let buttonTitle: String?
    let retryAction: (() -> Void)?
    
    init(
        errorImage: Image,
        errorTitle: String,
        errorMessage: String,
        buttonTitle: String? = nil,
        retryAction: (() -> Void)? = nil
    ) {
        self.errorImage = errorImage
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.buttonTitle = buttonTitle
        self.retryAction = retryAction
    }
    
    
    static func == (lhs: CustomError, rhs: CustomError) -> Bool {
        lhs.buttonTitle == rhs.buttonTitle
    }
}

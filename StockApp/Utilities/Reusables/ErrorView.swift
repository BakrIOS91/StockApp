//
//  ErrorView.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftUI

struct ErrorView: View {
    let image: Image?
    let title: String?
    let message: String
    let buttonText: String?
    let buttonAction: (() -> Void)?
    
    init(
        image: Image? = nil,
        title: String? = nil,
        message: String,
        buttonText: String? = nil,
        buttonAction: (() -> Void)? = nil,
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.001)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if let image = image {
                    VStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .setFrame(width: 126, height: 126)
                            .foregroundStyle(Color.appPrimaryColor)
                        
                        if let title = title {
                            Text(title)
                                .textStyle(
                                    weight: .bold,
                                    size: 24,
                                    color: .appBlack
                                )
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                
                Text(message)
                    .textStyle(
                        weight: .regular,
                        size: 14,
                        color: .descriptionGrayColor
                    )
                    .setPadding(.horizontal, 18)
                    .multilineTextAlignment(.center)
                
                
                if let buttonText = buttonText, let buttonAction = buttonAction {
                    Button {
                        buttonAction()
                    } label: {
                        HStack {
                            Spacer()
                            
                            Text(buttonText)
                                .textStyle(
                                    weight: .regular,
                                    size: 14,
                                    color: .appWhite
                                )
                            Spacer()
                        }
                    }
                    .setFrame(height: 44)
                    .background(Color.appMainColor.setCornerRadius(8, corners: .allCorners))
                }
            }
            .setPadding()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var viewState: ViewState = .serverError("")
    
    WithViewState(
        viewState: $viewState,
        isRefreshable: true) {
            VStack {
                Text("Helo World")
                
                Button {
                    
                } label: {
                    Text("Button")
                }
            }
        } retryAction: {
            print("Retry tabbed")
        }

}

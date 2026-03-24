//
//  WithViewState.swift
//  StockApp
//
//  Created by Bakr Mohamed on 24/03/2026.
//

import SwiftUI
import BMSwiftUI
import LoaderUI

struct WithViewState<Content: View>: View {
    
    @State private var isRefreshable: Bool
    @Binding private var viewState: ViewState
    private var retryAction: () -> Void
    let content: () -> Content
    
    init(
        viewState: Binding<ViewState>,
        isRefreshable: Bool = false,
        _ content: @escaping () -> Content,
        retryAction: @escaping () -> Void = {}
    ) {
        self._viewState = viewState
        self.isRefreshable = isRefreshable
        self.content = content
        self.retryAction = retryAction
    }
    
    var body: some View {
        ZStack {
            Color.appMainBackground.ignoresSafeArea()
            content()
                .refreshable {
                    retryAction()
                }
                .isHidden(viewState != .loaded && viewState != .loading, remove: false)
            
            stateView
        }
    }
    

    @ViewBuilder
    private var stateView: some View {
        switch viewState {
        case .loading:
            ZStack {
                Color.white.opacity(0.001)
                    .ignoresSafeArea()
                loaderView
            }
        case .overlayLoading(let color):
            ZStack {
                color
                loaderView
            }
        case .loaded:
            EmptyView()
        case .noNetwork:
            ErrorView(
                image: Image.noNetwork,
                title: Localized.errorNoNetworkTitle,
                message: Localized.errorNoNetworkDescription,
                buttonText: Localized.commonTryAgain,
                buttonAction: retryAction
            )
        case .customState(let customError):
            ErrorView(
                image: customError.errorImage,
                title: customError.errorTitle,
                message: customError.errorMessage,
                buttonText: customError.buttonTitle,
                buttonAction: retryAction
            )
        case .noData:
            ErrorView(
                image: Image.noData,
                title: Localized.errorNoDataTitle,
                message: Localized.errorNoDataDescription
            )
        case .serverError:
            ErrorView(
                image: Image.serverErorr,
                title: Localized.errorServerTitle,
                message: Localized.errorServerDescription,
                buttonText: Localized.commonTryAgain,
                buttonAction: retryAction
            )
        case .searchError:
            ErrorView(
                image: Image.searchError,
                title: Localized.errorSearchTitle,
                message: Localized.errorSearchDescription
            )
        case .unExpectedError:
            ErrorView(
                image: Image.unexpectedError,
                title: Localized.errorUnexpectedTitle,
                message: Localized.errorUnexpectedDescription,
                buttonText: Localized.commonTryAgain,
                buttonAction: retryAction
            )
        default:
            EmptyView()
        }
    }
    
    private var loaderView: some View {
        VStack {
            Spacer()
            
            BallPulseSync()
                .foregroundStyle(Color.appPrimaryColor)
            
            Spacer()
        }
    }

}


@available(iOS 17.0, *)
#Preview {
    @Previewable @State var viewState: ViewState = .loading
    
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

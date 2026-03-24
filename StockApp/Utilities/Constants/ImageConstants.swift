import SwiftUI

enum ImageConstants {
    static let appLogo = "appLogo"
    static let noData = "noData"
    static let noNetwork = "noNetwork"
    static let searchError = "searchError"
    static let serverErorr = "serverErorr"
    static let unexpectedError = "unexpectedError"
}

extension Image {
    static let appLogo = Image(ImageConstants.appLogo)
    static let noData = Image(ImageConstants.noData)
    static let noNetwork = Image(ImageConstants.noNetwork)
    static let searchError = Image(ImageConstants.searchError)
    static let serverErorr = Image(ImageConstants.serverErorr)
    static let unexpectedError = Image(ImageConstants.unexpectedError)
}

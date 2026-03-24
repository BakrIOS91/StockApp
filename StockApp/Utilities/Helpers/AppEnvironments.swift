import Foundation

enum AppEnvironments {
    // These keys are obfuscated and decoded at runtime
    private static let salt: [UInt8] = [132, 210, 146, 240, 235, 138, 21, 166, 119, 132, 217, 86, 242, 21, 82, 169, 50, 37, 6, 22, 206, 52, 168, 213, 37, 105, 209, 104, 44, 142, 89, 40]
    private static let obfuscatedHost: [UInt8] = [253, 186, 191, 150, 130, 228, 116, 200, 20, 225, 247, 38, 220, 103, 51, 217, 91, 65, 103, 102, 167, 26, 203, 186, 72]
    private static let obfuscatedKey: [UInt8] = [183, 182, 247, 198, 136, 236, 115, 146, 71, 231, 180, 37, 154, 36, 107, 202, 81, 29, 49, 119, 254, 86, 204, 230, 68, 13, 231, 80, 92, 191, 63, 24, 183, 227, 162, 154, 152, 228, 45, 151, 65, 188, 239, 103, 148, 45, 98, 156, 3, 65]

    private static func decode(_ obfuscated: [UInt8]) -> String {
        let decodedBytes = obfuscated.enumerated().map { (index, byte) in
            return byte ^ salt[index % salt.count]
        }
        return String(bytes: decodedBytes, encoding: .utf8) ?? ""
    }

    static var apiHost: String {
        return decode(obfuscatedHost)
    }

    static var apiKey: String {
        return decode(obfuscatedKey)
    }
}

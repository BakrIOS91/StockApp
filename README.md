# Moneybase - Financial Intelligence App

![Moneybase Logo](moneybase_logo.png)

Moneybase is a modern, premium financial intelligence application built with **SwiftUI**. It provides real-time stock market data, detailed financial analytics, and comprehensive company overviews, empowered by a robust and scalable architecture.

## 🚀 Key Features

- **Real-time Monitoring**: Live streaming of stock prices and market indices.
- **Advanced Search**: Instantly find companies and symbols across global markets.
- **Deep Analytics**: Comprehensive financial statistics including Market Cap, PE Ratios, and 52-week ranges.
- **Financial Insights**: Detailed breakdown of dividends, earnings, and quarterly estimates.
- **Visual Excellence**: A premium, dark-mode-first design with smooth transitions and an intuitive user experience.

## 🛠 Technical Stack & Architecture

Moneybase is built on a custom framework designed for reliability and developer productivity.

### Core Frameworks
- **BMSwiftUI**: A custom framework providing the foundation for State Management, Navigation, and UI components.
- **BMSwiftNetworking**: A protocol-oriented networking layer with built-in support for Async/Await and Result streams.

### Architectural Patterns
- **BaseViewModel Pattern**: Every view model inherits from a core `BaseViewModel`, ensuring consistent lifecycle management and state handling.
- **ViewModelEffect**: A synchronous-to-asynchronous bridge that allows view models to handle side effects (like network calls) without exposing `async` complexity to the UI.
- **Automatic Task Cancellation**: Integrated task management in `BaseViewModel` that automatically cancels redundant network requests when navigating between views, preventing memory leaks and high bandwidth usage.
- **Dependency Injection**: A custom, environment-aware injection system that seamlessly switches between live services, mock data for testing, and preview values for SwiftUI Previews.

## 🧪 Testing

The project prioritizes reliability with a comprehensive suite of unit tests using the modern **Swift Testing** framework.

- **StockListViewModelTests**: Covers data mapping, search logic, and state transitions for the main dashboard.
- **StockDetailsViewModelTests**: Ensures correctness of detailed analytics, success/failure branches, and UI-specific logic like description expansion.

Run tests using:
```bash
xcodebuild test -project StockApp.xcodeproj -scheme StockApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 📦 Setup & Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/BakrIOS91/StockApp.git
    ```
2.  **Open in Xcode**:
    Open `StockApp.xcodeproj`.
3.  **Packages**:
    The project uses SPM for its internal frameworks (`BMSwiftUI` and `BMSwiftNetworking`). Ensure they are resolved.
4.  **Run**:
    Select a simulator and hit `Cmd + R`.

---
*Created with focus on high performance and clean code.*

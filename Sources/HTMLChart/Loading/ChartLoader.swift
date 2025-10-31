import Foundation
import HTML

/// Protocol for Chart.js loading strategies
public protocol ChartLoader: HTML {
  var loadingStrategy: ChartLoadingStrategy { get }
}

/// Available loading strategies for Chart.js
public enum ChartLoadingStrategy: Sendable {
  case cdn(version: String, minified: Bool = true)
  case npm(path: String)
  case esm(url: String)
  case custom(url: String)
}

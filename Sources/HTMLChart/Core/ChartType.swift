import Foundation

/// Represents the different types of charts available in Chart.js
public enum ChartType: String, Sendable, CaseIterable, Codable {
  case line
  case bar
  case radar
  case doughnut
  case pie
  case polarArea
  case bubble
  case scatter

  /// The string value used by Chart.js
  public var chartJsType: String {
    switch self {
    case .polarArea:
      return "polarArea"
    default:
      return self.rawValue
    }
  }

  /// Whether this chart type supports stacking
  public var supportsStacking: Bool {
    switch self {
    case .line, .bar:
      return true
    default:
      return false
    }
  }

  /// Whether this chart type is radial (circular)
  public var isRadial: Bool {
    switch self {
    case .radar, .polarArea:
      return true
    default:
      return false
    }
  }

  /// Whether this chart type is circular (pie-like)
  public var isCircular: Bool {
    switch self {
    case .doughnut, .pie, .polarArea:
      return true
    default:
      return false
    }
  }
}

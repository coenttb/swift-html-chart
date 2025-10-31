import Foundation

/// Configuration for chart layout and padding
public struct LayoutOptions: Sendable {
  public let padding: PaddingValue?
  public let autoPadding: Bool?

  public init(
    padding: PaddingValue? = nil,
    autoPadding: Bool? = true
  ) {
    self.padding = padding
    self.autoPadding = autoPadding
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let padding = padding {
      dict["padding"] = padding.jsValue
    }
    if let autoPadding = autoPadding {
      dict["autoPadding"] = autoPadding
    }

    return dict
  }
}

/// Padding value that can be uniform or per-side
public enum PaddingValue: Sendable {
  case uniform(Double)
  case sides(top: Double, right: Double, bottom: Double, left: Double)
  case vertical(Double, horizontal: Double)

  var jsValue: Any {
    switch self {
    case .uniform(let value):
      return value
    case .sides(let top, let right, let bottom, let left):
      return [
        "top": top,
        "right": right,
        "bottom": bottom,
        "left": left,
      ]
    case .vertical(let vertical, let horizontal):
      return [
        "top": vertical,
        "right": horizontal,
        "bottom": vertical,
        "left": horizontal,
      ]
    }
  }
}

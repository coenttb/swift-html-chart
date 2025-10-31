import Foundation

/// Dataset specifically for bar charts
public struct BarDataset: ChartDataset {
  public let label: String
  public let data: [ChartValue]
  public let backgroundColor: ChartColor?
  public let borderColor: ChartColor?
  public let borderWidth: Double?
  public let hidden: Bool
  public let order: Int?

  // Bar-specific properties
  public let barPercentage: Double?
  public let categoryPercentage: Double?
  public let barThickness: Double?
  public let maxBarThickness: Double?
  public let minBarLength: Double?
  public let borderRadius: BorderRadius?
  public let borderSkipped: BorderSkipped?
  public let inflateAmount: Double?
  public let grouped: Bool?
  public let stack: String?
  public let base: Double?

  public init(
    label: String,
    data: [ChartValue],
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = 0,
    hidden: Bool = false,
    order: Int? = nil,
    barPercentage: Double? = 0.9,
    categoryPercentage: Double? = 0.8,
    barThickness: Double? = nil,
    maxBarThickness: Double? = nil,
    minBarLength: Double? = nil,
    borderRadius: BorderRadius? = nil,
    borderSkipped: BorderSkipped? = .start,
    inflateAmount: Double? = nil,
    grouped: Bool? = true,
    stack: String? = nil,
    base: Double? = nil
  ) {
    self.label = label
    self.data = data
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.hidden = hidden
    self.order = order
    self.barPercentage = barPercentage
    self.categoryPercentage = categoryPercentage
    self.barThickness = barThickness
    self.maxBarThickness = maxBarThickness
    self.minBarLength = minBarLength
    self.borderRadius = borderRadius
    self.borderSkipped = borderSkipped
    self.inflateAmount = inflateAmount
    self.grouped = grouped
    self.stack = stack
    self.base = base
  }

  /// Convenience initializer for numeric data
  public init(
    label: String,
    data: [Double],
    backgroundColor: ChartColor,
    stack: String? = nil
  ) {
    self.init(
      label: label,
      data: data.map { .number($0) },
      backgroundColor: backgroundColor,
      borderColor: backgroundColor,
      stack: stack
    )
  }

  public func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [
      "label": label,
      "data": data.map { $0.jsValue },
      "hidden": hidden,
    ]

    if let backgroundColor = backgroundColor {
      dict["backgroundColor"] = backgroundColor.value
    }
    if let borderColor = borderColor {
      dict["borderColor"] = borderColor.value
    }
    if let borderWidth = borderWidth {
      dict["borderWidth"] = borderWidth
    }
    if let order = order {
      dict["order"] = order
    }
    if let barPercentage = barPercentage {
      dict["barPercentage"] = barPercentage
    }
    if let categoryPercentage = categoryPercentage {
      dict["categoryPercentage"] = categoryPercentage
    }
    if let barThickness = barThickness {
      dict["barThickness"] = barThickness
    }
    if let maxBarThickness = maxBarThickness {
      dict["maxBarThickness"] = maxBarThickness
    }
    if let minBarLength = minBarLength {
      dict["minBarLength"] = minBarLength
    }
    if let borderRadius = borderRadius {
      dict["borderRadius"] = borderRadius.jsValue
    }
    if let borderSkipped = borderSkipped {
      dict["borderSkipped"] = borderSkipped.rawValue
    }
    if let inflateAmount = inflateAmount {
      dict["inflateAmount"] = inflateAmount
    }
    if let grouped = grouped {
      dict["grouped"] = grouped
    }
    if let stack = stack {
      dict["stack"] = stack
    }
    if let base = base {
      dict["base"] = base
    }

    return dict
  }
}

/// Border radius configuration for bars
public enum BorderRadius: Sendable {
  case uniform(Double)
  case topBottom(top: Double, bottom: Double)
  case corners(topLeft: Double, topRight: Double, bottomLeft: Double, bottomRight: Double)

  var jsValue: Any {
    switch self {
    case .uniform(let radius):
      return radius
    case .topBottom(let top, let bottom):
      return ["top": top, "bottom": bottom]
    case .corners(let topLeft, let topRight, let bottomLeft, let bottomRight):
      return [
        "topLeft": topLeft,
        "topRight": topRight,
        "bottomLeft": bottomLeft,
        "bottomRight": bottomRight,
      ]
    }
  }
}

/// Which borders to skip when drawing bars
public enum BorderSkipped: String, Sendable {
  case start
  case end
  case middle
  case bottom
  case left
  case top
  case right
  case none = "false"
}

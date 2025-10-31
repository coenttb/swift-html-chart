import Foundation

/// Dataset specifically for line charts
public struct LineDataset: ChartDataset {
  public let label: String
  public let data: [ChartValue]
  public let backgroundColor: ChartColor?
  public let borderColor: ChartColor?
  public let borderWidth: Double?
  public let hidden: Bool
  public let order: Int?

  // Line-specific properties
  public let tension: Double?
  public let fill: ChartFill?
  public let stepped: Bool?
  public let pointRadius: Double?
  public let pointHoverRadius: Double?
  public let pointBackgroundColor: ChartColor?
  public let pointBorderColor: ChartColor?
  public let pointBorderWidth: Double?
  public let pointStyle: PointStyle?
  public let showLine: Bool?
  public let spanGaps: Bool?
  public let segment: SegmentConfiguration?
  public let cubicInterpolationMode: CubicInterpolationMode?

  public init(
    label: String,
    data: [ChartValue],
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = 2,
    hidden: Bool = false,
    order: Int? = nil,
    tension: Double? = 0.0,
    fill: ChartFill? = nil,
    stepped: Bool? = nil,
    pointRadius: Double? = 3,
    pointHoverRadius: Double? = 4,
    pointBackgroundColor: ChartColor? = nil,
    pointBorderColor: ChartColor? = nil,
    pointBorderWidth: Double? = 1,
    pointStyle: PointStyle? = .circle,
    showLine: Bool? = true,
    spanGaps: Bool? = nil,
    segment: SegmentConfiguration? = nil,
    cubicInterpolationMode: CubicInterpolationMode? = nil
  ) {
    self.label = label
    self.data = data
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.hidden = hidden
    self.order = order
    self.tension = tension
    self.fill = fill
    self.stepped = stepped
    self.pointRadius = pointRadius
    self.pointHoverRadius = pointHoverRadius
    self.pointBackgroundColor = pointBackgroundColor
    self.pointBorderColor = pointBorderColor
    self.pointBorderWidth = pointBorderWidth
    self.pointStyle = pointStyle
    self.showLine = showLine
    self.spanGaps = spanGaps
    self.segment = segment
    self.cubicInterpolationMode = cubicInterpolationMode
  }

  /// Convenience initializer for numeric data
  public init(
    label: String,
    data: [Double],
    borderColor: ChartColor,
    tension: Double = 0.0,
    fill: Bool = false
  ) {
    self.init(
      label: label,
      data: data.map { .number($0) },
      backgroundColor: fill ? borderColor.withAlpha(0.2) : nil,
      borderColor: borderColor,
      tension: tension,
      fill: fill ? .origin : ChartFill.none
    )
  }

  public func toDictionary() -> [String: Any] {
    var dict = defaultDictionary()

    if let tension = tension {
      dict["tension"] = tension
    }
    if let fill = fill {
      dict["fill"] = fill.jsValue
    }
    if let stepped = stepped {
      dict["stepped"] = stepped
    }
    if let pointRadius = pointRadius {
      dict["pointRadius"] = pointRadius
    }
    if let pointHoverRadius = pointHoverRadius {
      dict["pointHoverRadius"] = pointHoverRadius
    }
    if let pointBackgroundColor = pointBackgroundColor {
      dict["pointBackgroundColor"] = pointBackgroundColor.value
    }
    if let pointBorderColor = pointBorderColor {
      dict["pointBorderColor"] = pointBorderColor.value
    }
    if let pointBorderWidth = pointBorderWidth {
      dict["pointBorderWidth"] = pointBorderWidth
    }
    if let pointStyle = pointStyle {
      dict["pointStyle"] = pointStyle.rawValue
    }
    if let showLine = showLine {
      dict["showLine"] = showLine
    }
    if let spanGaps = spanGaps {
      dict["spanGaps"] = spanGaps
    }
    if let cubicInterpolationMode = cubicInterpolationMode {
      dict["cubicInterpolationMode"] = cubicInterpolationMode.rawValue
    }

    return dict
  }

  private func defaultDictionary() -> [String: Any] {
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

    return dict
  }
}

/// Fill options for line charts
public enum ChartFill: Sendable {
  case none
  case origin
  case start
  case end
  case stack
  case shape
  case relative(Int)
  case absolute(Int)
  case dataset(Int)

  var jsValue: Any {
    switch self {
    case .none:
      return false
    case .origin:
      return "origin"
    case .start:
      return "start"
    case .end:
      return "end"
    case .stack:
      return "stack"
    case .shape:
      return "shape"
    case .relative(let index):
      return index > 0 ? "+\(index)" : "\(index)"
    case .absolute(let index):
      return index
    case .dataset(let index):
      return ["target": index]
    }
  }
}

/// Point styles available in Chart.js
public enum PointStyle: String, Sendable, CaseIterable {
  case circle
  case cross
  case crossRot
  case dash
  case line
  case rect
  case rectRounded
  case rectRot
  case star
  case triangle
}

/// Cubic interpolation modes for line charts
public enum CubicInterpolationMode: String, Sendable {
  case `default`
  case monotone
}

/// Segment configuration for styling line segments differently
public struct SegmentConfiguration: Sendable {
  // This would contain segment-specific styling
  // Simplified for this implementation
}

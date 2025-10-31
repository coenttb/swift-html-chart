import Foundation

/// Dataset specifically for pie charts
public struct PieDataset: ChartDataset {
  public let label: String
  public let data: [ChartValue]
  public let backgroundColor: ChartColor?
  public let borderColor: ChartColor?
  public let borderWidth: Double?
  public let hidden: Bool
  public let order: Int?

  // Pie-specific properties
  public let rotation: Double?
  public let circumference: Double?
  public let borderAlign: BorderAlign?
  public let borderRadius: Double?
  public let hoverOffset: Double?
  public let offset: Double?
  public let spacing: Double?
  public let weight: Double?

  // Multiple colors for pie segments
  public let backgroundColors: [ChartColor]?
  public let borderColors: [ChartColor]?
  public let hoverBackgroundColors: [ChartColor]?
  public let hoverBorderColors: [ChartColor]?

  public init(
    label: String = "Pie Data",
    data: [ChartValue],
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = 1,
    hidden: Bool = false,
    order: Int? = nil,
    rotation: Double? = nil,
    circumference: Double? = 360,
    borderAlign: BorderAlign? = .center,
    borderRadius: Double? = 0,
    hoverOffset: Double? = 4,
    offset: Double? = 0,
    spacing: Double? = 0,
    weight: Double? = 1,
    backgroundColors: [ChartColor]? = nil,
    borderColors: [ChartColor]? = nil,
    hoverBackgroundColors: [ChartColor]? = nil,
    hoverBorderColors: [ChartColor]? = nil
  ) {
    self.label = label
    self.data = data
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.hidden = hidden
    self.order = order
    self.rotation = rotation
    self.circumference = circumference
    self.borderAlign = borderAlign
    self.borderRadius = borderRadius
    self.hoverOffset = hoverOffset
    self.offset = offset
    self.spacing = spacing
    self.weight = weight
    self.backgroundColors = backgroundColors
    self.borderColors = borderColors
    self.hoverBackgroundColors = hoverBackgroundColors
    self.hoverBorderColors = hoverBorderColors
  }

  /// Convenience initializer with automatic colors
  public init(
    data: [Double],
    labels: [String]? = nil
  ) {
    let colors = ChartColor.defaultPalette.prefix(data.count)
    self.init(
      data: data.map { .number($0) },
      backgroundColors: Array(colors)
    )
  }

  public func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [
      "label": label,
      "data": data.map { $0.jsValue },
      "hidden": hidden,
    ]

    // Use array of colors if provided, otherwise single color
    if let backgroundColors = backgroundColors, !backgroundColors.isEmpty {
      dict["backgroundColor"] = backgroundColors.map { $0.value }
    } else if let backgroundColor = backgroundColor {
      dict["backgroundColor"] = backgroundColor.value
    }

    if let borderColors = borderColors, !borderColors.isEmpty {
      dict["borderColor"] = borderColors.map { $0.value }
    } else if let borderColor = borderColor {
      dict["borderColor"] = borderColor.value
    }

    if let borderWidth = borderWidth {
      dict["borderWidth"] = borderWidth
    }
    if let order = order {
      dict["order"] = order
    }
    if let rotation = rotation {
      dict["rotation"] = rotation
    }
    if let circumference = circumference {
      dict["circumference"] = circumference
    }
    if let borderAlign = borderAlign {
      dict["borderAlign"] = borderAlign.rawValue
    }
    if let borderRadius = borderRadius {
      dict["borderRadius"] = borderRadius
    }
    if let hoverOffset = hoverOffset {
      dict["hoverOffset"] = hoverOffset
    }
    if let offset = offset {
      dict["offset"] = offset
    }
    if let spacing = spacing {
      dict["spacing"] = spacing
    }
    if let weight = weight {
      dict["weight"] = weight
    }
    if let hoverBackgroundColors = hoverBackgroundColors, !hoverBackgroundColors.isEmpty {
      dict["hoverBackgroundColor"] = hoverBackgroundColors.map { $0.value }
    }
    if let hoverBorderColors = hoverBorderColors, !hoverBorderColors.isEmpty {
      dict["hoverBorderColor"] = hoverBorderColors.map { $0.value }
    }

    return dict
  }
}

/// Dataset specifically for doughnut charts (extends pie with cutout)
public struct DoughnutDataset: ChartDataset {
  private let pieDataset: PieDataset
  public let cutout: CutoutValue?

  // Forwarding protocol requirements
  public var label: String { pieDataset.label }
  public var data: [ChartValue] { pieDataset.data }
  public var backgroundColor: ChartColor? { pieDataset.backgroundColor }
  public var borderColor: ChartColor? { pieDataset.borderColor }
  public var borderWidth: Double? { pieDataset.borderWidth }
  public var hidden: Bool { pieDataset.hidden }
  public var order: Int? { pieDataset.order }

  public init(
    label: String = "Doughnut Data",
    data: [ChartValue],
    cutout: CutoutValue? = .percentage(50),
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = 1,
    hidden: Bool = false,
    order: Int? = nil,
    rotation: Double? = nil,
    circumference: Double? = 360,
    borderAlign: BorderAlign? = .center,
    borderRadius: Double? = 0,
    hoverOffset: Double? = 4,
    offset: Double? = 0,
    spacing: Double? = 0,
    weight: Double? = 1,
    backgroundColors: [ChartColor]? = nil,
    borderColors: [ChartColor]? = nil,
    hoverBackgroundColors: [ChartColor]? = nil,
    hoverBorderColors: [ChartColor]? = nil
  ) {
    self.pieDataset = PieDataset(
      label: label,
      data: data,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      hidden: hidden,
      order: order,
      rotation: rotation,
      circumference: circumference,
      borderAlign: borderAlign,
      borderRadius: borderRadius,
      hoverOffset: hoverOffset,
      offset: offset,
      spacing: spacing,
      weight: weight,
      backgroundColors: backgroundColors,
      borderColors: borderColors,
      hoverBackgroundColors: hoverBackgroundColors,
      hoverBorderColors: hoverBorderColors
    )
    self.cutout = cutout
  }

  public func toDictionary() -> [String: Any] {
    var dict = pieDataset.toDictionary()
    if let cutout = cutout {
      dict["cutout"] = cutout.jsValue
    }
    return dict
  }
}

/// Border alignment for pie/doughnut charts
public enum BorderAlign: String, Sendable {
  case center
  case inner
}

/// Cutout value for doughnut charts
public enum CutoutValue: Sendable {
  case pixels(Double)
  case percentage(Double)

  var jsValue: Any {
    switch self {
    case .pixels(let value):
      return value
    case .percentage(let value):
      return "\(value)%"
    }
  }
}

// MARK: - Default Color Palette
extension ChartColor {
  public static let defaultPalette: [ChartColor] = [
    .rgb(255, 99, 132),
    .rgb(54, 162, 235),
    .rgb(255, 205, 86),
    .rgb(75, 192, 192),
    .rgb(153, 102, 255),
    .rgb(255, 159, 64),
    .rgb(199, 199, 199),
    .rgb(83, 102, 255),
    .rgb(255, 99, 255),
    .rgb(99, 255, 132),
    .rgb(255, 193, 7),
    .rgb(32, 201, 151),
  ]
}

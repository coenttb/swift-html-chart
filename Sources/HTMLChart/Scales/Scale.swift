import Foundation

/// Protocol for all chart scales
public protocol Scale: Sendable {
  var type: ScaleType { get }
  var display: Bool? { get }
  var position: ScalePosition? { get }
  var offset: Bool? { get }
  var title: ScaleTitle? { get }
  var ticks: TickOptions? { get }
  var grid: GridOptions? { get }
  var border: BorderOptions? { get }
  var min: Double? { get }
  var max: Double? { get }
  var suggestedMin: Double? { get }
  var suggestedMax: Double? { get }
  var reverse: Bool? { get }
  var stacked: Bool? { get }
  var weight: Double? { get }
  var id: String? { get }
  var clip: Bool? { get }

  func toDictionary() -> [String: Any]
}

/// Default implementation for common scale properties
extension Scale {
  public func baseDictionary() -> [String: Any] {
    var dict: [String: Any] = [
      "type": type.rawValue
    ]

    if let display = display {
      dict["display"] = display
    }
    if let position = position {
      dict["position"] = position.rawValue
    }
    if let offset = offset {
      dict["offset"] = offset
    }
    if let title = title {
      dict["title"] = title.toDictionary()
    }
    if let ticks = ticks {
      dict["ticks"] = ticks.toDictionary()
    }
    if let grid = grid {
      dict["grid"] = grid.toDictionary()
    }
    if let border = border {
      dict["border"] = border.toDictionary()
    }
    if let min = min {
      dict["min"] = min
    }
    if let max = max {
      dict["max"] = max
    }
    if let suggestedMin = suggestedMin {
      dict["suggestedMin"] = suggestedMin
    }
    if let suggestedMax = suggestedMax {
      dict["suggestedMax"] = suggestedMax
    }
    if let reverse = reverse {
      dict["reverse"] = reverse
    }
    if let stacked = stacked {
      dict["stacked"] = stacked
    }
    if let weight = weight {
      dict["weight"] = weight
    }
    if let id = id {
      dict["id"] = id
    }
    if let clip = clip {
      dict["clip"] = clip
    }

    return dict
  }
}

/// Types of scales available in Chart.js
public enum ScaleType: String, Sendable {
  case linear
  case logarithmic
  case category
  case time
  case timeseries
  case radialLinear
}

/// Position of the scale
public enum ScalePosition: String, Sendable {
  case top
  case left
  case bottom
  case right
  case center
  case chartArea
}

/// Scale title configuration
public struct ScaleTitle: Sendable {
  public let display: Bool?
  public let text: String?
  public let color: ChartColor?
  public let font: FontOptions?
  public let padding: PaddingValue?
  public let align: TitleAlign?

  public init(
    display: Bool? = true,
    text: String? = nil,
    color: ChartColor? = nil,
    font: FontOptions? = nil,
    padding: PaddingValue? = nil,
    align: TitleAlign? = .center
  ) {
    self.display = display
    self.text = text
    self.color = color
    self.font = font
    self.padding = padding
    self.align = align
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let display = display {
      dict["display"] = display
    }
    if let text = text {
      dict["text"] = text
    }
    if let color = color {
      dict["color"] = color.value
    }
    if let font = font {
      dict["font"] = font.toDictionary()
    }
    if let padding = padding {
      dict["padding"] = padding.jsValue
    }
    if let align = align {
      dict["align"] = align.rawValue
    }

    return dict
  }
}

/// Title alignment options
public enum TitleAlign: String, Sendable {
  case start
  case center
  case end
}

/// Configuration for scale ticks
public struct TickOptions: Sendable {
  public let display: Bool?
  public let color: ChartColor?
  public let font: FontOptions?
  public let padding: Double?
  public let textStrokeColor: ChartColor?
  public let textStrokeWidth: Double?
  public let z: Int?
  public let major: MajorTickOptions?
  public let maxRotation: Double?
  public let minRotation: Double?
  public let mirror: Bool?
  public let autoSkip: Bool?
  public let autoSkipPadding: Double?
  public let labelOffset: Double?
  public let maxTicksLimit: Int?
  public let stepSize: Double?
  public let count: Int?
  public let precision: Int?
  public let callback: String?  // JavaScript function as string
  public let format: String?  // Number format string
  public let showLabelBackdrop: Bool?
  public let backdropColor: ChartColor?
  public let backdropPadding: PaddingValue?
  public let align: TickAlign?
  public let crossAlign: CrossAlign?
  public let sampleSize: Int?
  public let includeBounds: Bool?
  public let source: TickSource?

  public init(
    display: Bool? = true,
    color: ChartColor? = nil,
    font: FontOptions? = nil,
    padding: Double? = 3,
    textStrokeColor: ChartColor? = nil,
    textStrokeWidth: Double? = nil,
    z: Int? = nil,
    major: MajorTickOptions? = nil,
    maxRotation: Double? = 50,
    minRotation: Double? = 0,
    mirror: Bool? = false,
    autoSkip: Bool? = true,
    autoSkipPadding: Double? = 3,
    labelOffset: Double? = 0,
    maxTicksLimit: Int? = nil,
    stepSize: Double? = nil,
    count: Int? = nil,
    precision: Int? = nil,
    callback: String? = nil,
    format: String? = nil,
    showLabelBackdrop: Bool? = false,
    backdropColor: ChartColor? = nil,
    backdropPadding: PaddingValue? = nil,
    align: TickAlign? = .center,
    crossAlign: CrossAlign? = .near,
    sampleSize: Int? = nil,
    includeBounds: Bool? = true,
    source: TickSource? = nil
  ) {
    self.display = display
    self.color = color
    self.font = font
    self.padding = padding
    self.textStrokeColor = textStrokeColor
    self.textStrokeWidth = textStrokeWidth
    self.z = z
    self.major = major
    self.maxRotation = maxRotation
    self.minRotation = minRotation
    self.mirror = mirror
    self.autoSkip = autoSkip
    self.autoSkipPadding = autoSkipPadding
    self.labelOffset = labelOffset
    self.maxTicksLimit = maxTicksLimit
    self.stepSize = stepSize
    self.count = count
    self.precision = precision
    self.callback = callback
    self.format = format
    self.showLabelBackdrop = showLabelBackdrop
    self.backdropColor = backdropColor
    self.backdropPadding = backdropPadding
    self.align = align
    self.crossAlign = crossAlign
    self.sampleSize = sampleSize
    self.includeBounds = includeBounds
    self.source = source
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let display = display {
      dict["display"] = display
    }
    if let color = color {
      dict["color"] = color.value
    }
    if let font = font {
      dict["font"] = font.toDictionary()
    }
    if let padding = padding {
      dict["padding"] = padding
    }
    if let maxRotation = maxRotation {
      dict["maxRotation"] = maxRotation
    }
    if let minRotation = minRotation {
      dict["minRotation"] = minRotation
    }
    if let autoSkip = autoSkip {
      dict["autoSkip"] = autoSkip
    }
    if let callback = callback {
      dict["callback"] = callback
    }
    // Add other properties as needed

    return dict
  }
}

/// Major tick configuration
public struct MajorTickOptions: Sendable {
  public let enabled: Bool?

  public init(enabled: Bool? = false) {
    self.enabled = enabled
  }
}

/// Tick alignment options
public enum TickAlign: String, Sendable {
  case start
  case center
  case end
  case inner
}

/// Cross alignment for ticks
public enum CrossAlign: String, Sendable {
  case near
  case center
  case far
}

/// Source for tick generation
public enum TickSource: String, Sendable {
  case auto
  case data
  case labels
}

/// Configuration for grid lines
public struct GridOptions: Sendable {
  public let display: Bool?
  public let circular: Bool?
  public let color: ChartColor?
  public let lineWidth: Double?
  public let drawOnChartArea: Bool?
  public let drawTicks: Bool?
  public let tickLength: Double?
  public let offset: Bool?
  public let z: Int?

  public init(
    display: Bool? = true,
    circular: Bool? = false,
    color: ChartColor? = nil,
    lineWidth: Double? = 1,
    drawOnChartArea: Bool? = true,
    drawTicks: Bool? = true,
    tickLength: Double? = 8,
    offset: Bool? = false,
    z: Int? = nil
  ) {
    self.display = display
    self.circular = circular
    self.color = color
    self.lineWidth = lineWidth
    self.drawOnChartArea = drawOnChartArea
    self.drawTicks = drawTicks
    self.tickLength = tickLength
    self.offset = offset
    self.z = z
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let display = display {
      dict["display"] = display
    }
    if let circular = circular {
      dict["circular"] = circular
    }
    if let color = color {
      dict["color"] = color.value
    }
    if let lineWidth = lineWidth {
      dict["lineWidth"] = lineWidth
    }
    if let drawOnChartArea = drawOnChartArea {
      dict["drawOnChartArea"] = drawOnChartArea
    }
    if let drawTicks = drawTicks {
      dict["drawTicks"] = drawTicks
    }
    if let tickLength = tickLength {
      dict["tickLength"] = tickLength
    }
    if let offset = offset {
      dict["offset"] = offset
    }
    if let z = z {
      dict["z"] = z
    }

    return dict
  }
}

/// Configuration for scale border
public struct BorderOptions: Sendable {
  public let display: Bool?
  public let color: ChartColor?
  public let width: Double?
  public let dash: [Double]?
  public let dashOffset: Double?
  public let z: Int?

  public init(
    display: Bool? = true,
    color: ChartColor? = nil,
    width: Double? = 1,
    dash: [Double]? = nil,
    dashOffset: Double? = 0,
    z: Int? = nil
  ) {
    self.display = display
    self.color = color
    self.width = width
    self.dash = dash
    self.dashOffset = dashOffset
    self.z = z
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let display = display {
      dict["display"] = display
    }
    if let color = color {
      dict["color"] = color.value
    }
    if let width = width {
      dict["width"] = width
    }
    if let dash = dash {
      dict["dash"] = dash
    }
    if let dashOffset = dashOffset {
      dict["dashOffset"] = dashOffset
    }
    if let z = z {
      dict["z"] = z
    }

    return dict
  }
}

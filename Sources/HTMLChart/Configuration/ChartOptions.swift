import Foundation

/// Comprehensive options for chart configuration
public struct ChartOptions: Sendable {
  public let responsive: Bool?
  public let maintainAspectRatio: Bool?
  public let aspectRatio: Double?
  public let resizeDelay: Int?
  public let devicePixelRatio: Double?
  public let locale: String?
  public let interaction: InteractionOptions?
  public let animation: AnimationOptions?
  public let layout: LayoutOptions?
  public let plugins: PluginOptions?
  public let scales: ScaleOptions?
  public let elements: ElementOptions?
  public let datasets: DatasetOptions?
  public let indexAxis: IndexAxis?
  public let clip: ClipValue?
  public let color: ChartColor?
  public let backgroundColor: ChartColor?
  public let borderColor: ChartColor?
  public let font: FontOptions?
  public let onHover: String?  // JavaScript function as string
  public let onClick: String?  // JavaScript function as string
  public let onResize: String?  // JavaScript function as string

  public init(
    responsive: Bool? = true,
    maintainAspectRatio: Bool? = true,
    aspectRatio: Double? = 2,
    resizeDelay: Int? = 0,
    devicePixelRatio: Double? = nil,
    locale: String? = nil,
    interaction: InteractionOptions? = nil,
    animation: AnimationOptions? = nil,
    layout: LayoutOptions? = nil,
    plugins: PluginOptions? = nil,
    scales: ScaleOptions? = nil,
    elements: ElementOptions? = nil,
    datasets: DatasetOptions? = nil,
    indexAxis: IndexAxis? = nil,
    clip: ClipValue? = nil,
    color: ChartColor? = nil,
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    font: FontOptions? = nil,
    onHover: String? = nil,
    onClick: String? = nil,
    onResize: String? = nil
  ) {
    self.responsive = responsive
    self.maintainAspectRatio = maintainAspectRatio
    self.aspectRatio = aspectRatio
    self.resizeDelay = resizeDelay
    self.devicePixelRatio = devicePixelRatio
    self.locale = locale
    self.interaction = interaction
    self.animation = animation
    self.layout = layout
    self.plugins = plugins
    self.scales = scales
    self.elements = elements
    self.datasets = datasets
    self.indexAxis = indexAxis
    self.clip = clip
    self.color = color
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.font = font
    self.onHover = onHover
    self.onClick = onClick
    self.onResize = onResize
  }

  public func toJavaScript() -> String {
    var options: [String: Any] = [:]

    if let responsive = responsive {
      options["responsive"] = responsive
    }
    if let maintainAspectRatio = maintainAspectRatio {
      options["maintainAspectRatio"] = maintainAspectRatio
    }
    if let aspectRatio = aspectRatio {
      options["aspectRatio"] = aspectRatio
    }
    if let resizeDelay = resizeDelay {
      options["resizeDelay"] = resizeDelay
    }
    if let devicePixelRatio = devicePixelRatio {
      options["devicePixelRatio"] = devicePixelRatio
    }
    if let locale = locale {
      options["locale"] = locale
    }
    if let interaction = interaction {
      options["interaction"] = interaction.toDictionary()
    }
    if let animation = animation {
      options["animation"] = animation.toDictionary()
    }
    if let layout = layout {
      options["layout"] = layout.toDictionary()
    }
    if let plugins = plugins {
      options["plugins"] = plugins.toDictionary()
    }
    if let scales = scales {
      options["scales"] = scales.toDictionary()
    }
    if let indexAxis = indexAxis {
      options["indexAxis"] = indexAxis.rawValue
    }
    if let color = color {
      options["color"] = color.value
    }
    if let backgroundColor = backgroundColor {
      options["backgroundColor"] = backgroundColor.value
    }
    if let borderColor = borderColor {
      options["borderColor"] = borderColor.value
    }
    if let font = font {
      options["font"] = font.toDictionary()
    }
    if let onHover = onHover {
      options["onHover"] = onHover
    }
    if let onClick = onClick {
      options["onClick"] = onClick
    }
    if let onResize = onResize {
      options["onResize"] = onResize
    }

    return optionsDictToJS(options)
  }

  private func optionsDictToJS(_ dict: [String: Any]) -> String {
    var js = "{\n"

    for (key, value) in dict {
      js += "    \(key): "

      switch value {
      case let str as String:
        if str.hasPrefix("function") || str.contains("=>") {
          js += str
        } else {
          js += "'\(str)'"
        }
      case let num as Double:
        js += String(num)
      case let num as Int:
        js += String(num)
      case let bool as Bool:
        js += bool ? "true" : "false"
      case let dict as [String: Any]:
        js += dictToJS(dict, indent: "    ")
      default:
        js += "null"
      }

      js += ",\n"
    }

    if js.hasSuffix(",\n") {
      js.removeLast(2)
      js += "\n"
    }

    js += "  }"
    return js
  }

  private func dictToJS(_ dict: [String: Any], indent: String) -> String {
    var js = "{\n"
    let nextIndent = indent + "  "

    for (key, value) in dict {
      js += "\(nextIndent)\(key): "

      switch value {
      case let str as String:
        if str.hasPrefix("function") || str.contains("=>") {
          js += str
        } else {
          js += "'\(str)'"
        }
      case let num as Double:
        js += String(num)
      case let num as Int:
        js += String(num)
      case let bool as Bool:
        js += bool ? "true" : "false"
      case let dict as [String: Any]:
        js += dictToJS(dict, indent: nextIndent)
      case let array as [Any]:
        js += "[\(array.map { arrayValueToJS($0) }.joined(separator: ", "))]"
      default:
        js += "null"
      }

      js += ",\n"
    }

    if js.hasSuffix(",\n") {
      js.removeLast(2)
      js += "\n"
    }

    js += "\(indent)}"
    return js
  }

  private func arrayValueToJS(_ value: Any) -> String {
    switch value {
    case let str as String:
      return "'\(str)'"
    case let num as Double:
      return String(num)
    case let num as Int:
      return String(num)
    case let bool as Bool:
      return bool ? "true" : "false"
    default:
      return "null"
    }
  }
}

/// Index axis for charts (x or y)
public enum IndexAxis: String, Sendable {
  case x
  case y
}

/// Clip value for chart rendering
public enum ClipValue: Sendable {
  case auto
  case pixels(Double)
  case disable

  var jsValue: Any {
    switch self {
    case .auto:
      return "auto"
    case .pixels(let value):
      return value
    case .disable:
      return false
    }
  }
}

/// Font options for text elements
public struct FontOptions: Sendable {
  public let family: String?
  public let size: Double?
  public let style: FontStyle?
  public let weight: FontWeight?
  public let lineHeight: Double?

  public init(
    family: String? = nil,
    size: Double? = nil,
    style: FontStyle? = nil,
    weight: FontWeight? = nil,
    lineHeight: Double? = nil
  ) {
    self.family = family
    self.size = size
    self.style = style
    self.weight = weight
    self.lineHeight = lineHeight
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]
    if let family = family {
      dict["family"] = family
    }
    if let size = size {
      dict["size"] = size
    }
    if let style = style {
      dict["style"] = style.rawValue
    }
    if let weight = weight {
      dict["weight"] = weight.jsValue
    }
    if let lineHeight = lineHeight {
      dict["lineHeight"] = lineHeight
    }
    return dict
  }
}

public enum FontStyle: String, Sendable {
  case normal
  case italic
  case oblique
}

public enum FontWeight: Sendable {
  case normal
  case bold
  case bolder
  case lighter
  case number(Int)

  var jsValue: Any {
    switch self {
    case .normal:
      return "normal"
    case .bold:
      return "bold"
    case .bolder:
      return "bolder"
    case .lighter:
      return "lighter"
    case .number(let weight):
      return weight
    }
  }
}

/// Element-specific options
public struct ElementOptions: Sendable {
  // Simplified for now - would contain options for point, line, bar, arc elements

  func toDictionary() -> [String: Any] {
    return [:]
  }
}

/// Dataset-specific options
public struct DatasetOptions: Sendable {
  // Simplified for now - would contain dataset-specific defaults

  func toDictionary() -> [String: Any] {
    return [:]
  }
}

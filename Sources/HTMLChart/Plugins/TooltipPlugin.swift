import Foundation

/// Tooltip plugin configuration
public struct TooltipOptions: Sendable {
  public let enabled: Bool?
  public let external: String?  // JavaScript function as string
  public let mode: InteractionMode?
  public let intersect: Bool?
  public let position: TooltipPosition?
  public let callbacks: TooltipCallbacks?
  public let itemSort: String?  // JavaScript function as string
  public let filter: String?  // JavaScript function as string
  public let backgroundColor: ChartColor?
  public let titleColor: ChartColor?
  public let titleFont: FontOptions?
  public let titleAlign: TextAlign?
  public let titleSpacing: Double?
  public let titleMarginBottom: Double?
  public let bodyColor: ChartColor?
  public let bodyFont: FontOptions?
  public let bodyAlign: TextAlign?
  public let bodySpacing: Double?
  public let footerColor: ChartColor?
  public let footerFont: FontOptions?
  public let footerAlign: TextAlign?
  public let footerSpacing: Double?
  public let footerMarginTop: Double?
  public let padding: PaddingValue?
  public let caretPadding: Double?
  public let caretSize: Double?
  public let cornerRadius: Double?
  public let multiKeyBackground: ChartColor?
  public let displayColors: Bool?
  public let boxWidth: Double?
  public let boxHeight: Double?
  public let boxPadding: Double?
  public let usePointStyle: Bool?
  public let borderColor: ChartColor?
  public let borderWidth: Double?
  public let rtl: Bool?
  public let textDirection: TextDirection?
  public let xAlign: TooltipAlign?
  public let yAlign: TooltipAlign?

  public init(
    enabled: Bool? = true,
    external: String? = nil,
    mode: InteractionMode? = .nearest,
    intersect: Bool? = true,
    position: TooltipPosition? = .average,
    callbacks: TooltipCallbacks? = nil,
    itemSort: String? = nil,
    filter: String? = nil,
    backgroundColor: ChartColor? = .rgba(0, 0, 0, 0.8),
    titleColor: ChartColor? = .white,
    titleFont: FontOptions? = nil,
    titleAlign: TextAlign? = .left,
    titleSpacing: Double? = 2,
    titleMarginBottom: Double? = 6,
    bodyColor: ChartColor? = .white,
    bodyFont: FontOptions? = nil,
    bodyAlign: TextAlign? = .left,
    bodySpacing: Double? = 2,
    footerColor: ChartColor? = .white,
    footerFont: FontOptions? = nil,
    footerAlign: TextAlign? = .left,
    footerSpacing: Double? = 2,
    footerMarginTop: Double? = 6,
    padding: PaddingValue? = .uniform(6),
    caretPadding: Double? = 2,
    caretSize: Double? = 5,
    cornerRadius: Double? = 6,
    multiKeyBackground: ChartColor? = .white,
    displayColors: Bool? = true,
    boxWidth: Double? = nil,
    boxHeight: Double? = nil,
    boxPadding: Double? = 1,
    usePointStyle: Bool? = false,
    borderColor: ChartColor? = .rgba(0, 0, 0, 0),
    borderWidth: Double? = 0,
    rtl: Bool? = false,
    textDirection: TextDirection? = .ltr,
    xAlign: TooltipAlign? = nil,
    yAlign: TooltipAlign? = nil
  ) {
    self.enabled = enabled
    self.external = external
    self.mode = mode
    self.intersect = intersect
    self.position = position
    self.callbacks = callbacks
    self.itemSort = itemSort
    self.filter = filter
    self.backgroundColor = backgroundColor
    self.titleColor = titleColor
    self.titleFont = titleFont
    self.titleAlign = titleAlign
    self.titleSpacing = titleSpacing
    self.titleMarginBottom = titleMarginBottom
    self.bodyColor = bodyColor
    self.bodyFont = bodyFont
    self.bodyAlign = bodyAlign
    self.bodySpacing = bodySpacing
    self.footerColor = footerColor
    self.footerFont = footerFont
    self.footerAlign = footerAlign
    self.footerSpacing = footerSpacing
    self.footerMarginTop = footerMarginTop
    self.padding = padding
    self.caretPadding = caretPadding
    self.caretSize = caretSize
    self.cornerRadius = cornerRadius
    self.multiKeyBackground = multiKeyBackground
    self.displayColors = displayColors
    self.boxWidth = boxWidth
    self.boxHeight = boxHeight
    self.boxPadding = boxPadding
    self.usePointStyle = usePointStyle
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.rtl = rtl
    self.textDirection = textDirection
    self.xAlign = xAlign
    self.yAlign = yAlign
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let enabled = enabled {
      dict["enabled"] = enabled
    }
    if let external = external {
      dict["external"] = external
    }
    if let mode = mode {
      dict["mode"] = mode.rawValue
    }
    if let intersect = intersect {
      dict["intersect"] = intersect
    }
    if let position = position {
      dict["position"] = position.rawValue
    }
    if let callbacks = callbacks {
      dict["callbacks"] = callbacks.toDictionary()
    }
    if let backgroundColor = backgroundColor {
      dict["backgroundColor"] = backgroundColor.value
    }
    if let titleColor = titleColor {
      dict["titleColor"] = titleColor.value
    }
    if let bodyColor = bodyColor {
      dict["bodyColor"] = bodyColor.value
    }
    if let padding = padding {
      dict["padding"] = padding.jsValue
    }
    if let displayColors = displayColors {
      dict["displayColors"] = displayColors
    }
    if let borderColor = borderColor {
      dict["borderColor"] = borderColor.value
    }
    if let borderWidth = borderWidth {
      dict["borderWidth"] = borderWidth
    }
    // Add other properties as needed

    return dict
  }
}

/// Tooltip position options
public enum TooltipPosition: String, Sendable {
  case average
  case nearest
}

/// Tooltip alignment options
public enum TooltipAlign: String, Sendable {
  case left
  case center
  case right
  case top
  case bottom
  case auto
}

/// Tooltip callback functions
public struct TooltipCallbacks: Sendable {
  public let beforeTitle: String?
  public let title: String?
  public let afterTitle: String?
  public let beforeBody: String?
  public let beforeLabel: String?
  public let label: String?
  public let labelColor: String?
  public let labelTextColor: String?
  public let labelPointStyle: String?
  public let afterLabel: String?
  public let afterBody: String?
  public let beforeFooter: String?
  public let footer: String?
  public let afterFooter: String?

  public init(
    beforeTitle: String? = nil,
    title: String? = nil,
    afterTitle: String? = nil,
    beforeBody: String? = nil,
    beforeLabel: String? = nil,
    label: String? = nil,
    labelColor: String? = nil,
    labelTextColor: String? = nil,
    labelPointStyle: String? = nil,
    afterLabel: String? = nil,
    afterBody: String? = nil,
    beforeFooter: String? = nil,
    footer: String? = nil,
    afterFooter: String? = nil
  ) {
    self.beforeTitle = beforeTitle
    self.title = title
    self.afterTitle = afterTitle
    self.beforeBody = beforeBody
    self.beforeLabel = beforeLabel
    self.label = label
    self.labelColor = labelColor
    self.labelTextColor = labelTextColor
    self.labelPointStyle = labelPointStyle
    self.afterLabel = afterLabel
    self.afterBody = afterBody
    self.beforeFooter = beforeFooter
    self.footer = footer
    self.afterFooter = afterFooter
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let beforeTitle = beforeTitle {
      dict["beforeTitle"] = beforeTitle
    }
    if let title = title {
      dict["title"] = title
    }
    if let afterTitle = afterTitle {
      dict["afterTitle"] = afterTitle
    }
    if let beforeBody = beforeBody {
      dict["beforeBody"] = beforeBody
    }
    if let beforeLabel = beforeLabel {
      dict["beforeLabel"] = beforeLabel
    }
    if let label = label {
      dict["label"] = label
    }
    if let labelColor = labelColor {
      dict["labelColor"] = labelColor
    }
    if let labelTextColor = labelTextColor {
      dict["labelTextColor"] = labelTextColor
    }
    if let labelPointStyle = labelPointStyle {
      dict["labelPointStyle"] = labelPointStyle
    }
    if let afterLabel = afterLabel {
      dict["afterLabel"] = afterLabel
    }
    if let afterBody = afterBody {
      dict["afterBody"] = afterBody
    }
    if let beforeFooter = beforeFooter {
      dict["beforeFooter"] = beforeFooter
    }
    if let footer = footer {
      dict["footer"] = footer
    }
    if let afterFooter = afterFooter {
      dict["afterFooter"] = afterFooter
    }

    return dict
  }
}

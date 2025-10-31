import Foundation

/// Title plugin configuration
public struct TitleOptions: Sendable {
  public let display: Bool?
  public let text: TitleText?
  public let color: ChartColor?
  public let font: FontOptions?
  public let position: TitlePosition?
  public let padding: PaddingValue?
  public let fullSize: Bool?
  public let align: TitleAlign?

  public init(
    display: Bool? = false,
    text: TitleText? = nil,
    color: ChartColor? = nil,
    font: FontOptions? = nil,
    position: TitlePosition? = .top,
    padding: PaddingValue? = .uniform(10),
    fullSize: Bool? = true,
    align: TitleAlign? = .center
  ) {
    self.display = display
    self.text = text
    self.color = color
    self.font = font
    self.position = position
    self.padding = padding
    self.fullSize = fullSize
    self.align = align
  }

  /// Convenience initializer for simple string title
  public init(_ text: String) {
    self.init(display: true, text: .single(text))
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    if let display = display {
      dict["display"] = display
    }
    if let text = text {
      switch text {
      case .single(let str):
        dict["text"] = str
      case .multi(let lines):
        dict["text"] = lines
      }
    }
    if let color = color {
      dict["color"] = color.value
    }
    if let font = font {
      dict["font"] = font.toDictionary()
    }
    if let position = position {
      dict["position"] = position.rawValue
    }
    if let padding = padding {
      dict["padding"] = padding.jsValue
    }
    if let fullSize = fullSize {
      dict["fullSize"] = fullSize
    }
    if let align = align {
      dict["align"] = align.rawValue
    }

    return dict
  }
}

/// Title text that can be single or multi-line
public enum TitleText: Sendable {
  case single(String)
  case multi([String])
}

/// Title position options
public enum TitlePosition: String, Sendable {
  case top
  case left
  case bottom
  case right
}

import Foundation

/// Container for all scales in a chart
public struct ScaleOptions: Sendable {
  public let scales: [String: any Scale]

  public init(scales: [String: any Scale] = [:]) {
    self.scales = scales
  }

  /// Convenience initializer for common x/y scales
  public init(x: (any Scale)? = nil, y: (any Scale)? = nil) {
    var scales: [String: any Scale] = [:]
    if let x = x {
      scales["x"] = x
    }
    if let y = y {
      scales["y"] = y
    }
    self.scales = scales
  }

  /// Add a scale with a custom ID
  public func adding(_ scale: any Scale, withId id: String) -> ScaleOptions {
    var newScales = scales
    newScales[id] = scale
    return ScaleOptions(scales: newScales)
  }

  func toDictionary() -> [String: Any] {
    var dict: [String: Any] = [:]

    for (id, scale) in scales {
      dict[id] = scale.toDictionary()
    }

    return dict
  }
}

/// Builder for creating scale configurations
public struct ScaleBuilder {
  private var scales: [String: any Scale] = [:]

  public init() {}

  public func x(_ scale: any Scale) -> ScaleBuilder {
    var builder = self
    builder.scales["x"] = scale
    return builder
  }

  public func y(_ scale: any Scale) -> ScaleBuilder {
    var builder = self
    builder.scales["y"] = scale
    return builder
  }

  public func r(_ scale: any Scale) -> ScaleBuilder {
    var builder = self
    builder.scales["r"] = scale
    return builder
  }

  public func custom(_ id: String, scale: any Scale) -> ScaleBuilder {
    var builder = self
    builder.scales[id] = scale
    return builder
  }

  public func build() -> ScaleOptions {
    ScaleOptions(scales: scales)
  }
}

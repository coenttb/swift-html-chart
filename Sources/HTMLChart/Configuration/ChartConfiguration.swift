import Foundation

/// Main configuration for a Chart.js chart
public struct ChartConfiguration: Sendable {
  public let type: ChartType
  public let data: ChartData
  public let options: ChartOptions?
  public let plugins: [ChartPlugin]?

  public init(
    type: ChartType,
    data: ChartData,
    options: ChartOptions? = nil,
    plugins: [ChartPlugin]? = nil
  ) {
    self.type = type
    self.data = data
    self.options = options
    self.plugins = plugins
  }

  /// Generate the JavaScript configuration object for Chart.js
  public func toJavaScript() -> String {
    var js = "{\n"
    js += "  type: '\(type.chartJsType)',\n"
    js += "  data: \(dataToJavaScript()),\n"

    if let options = options {
      js += "  options: \(options.toJavaScript())"
    } else {
      js += "  options: {}"
    }

    if let plugins = plugins, !plugins.isEmpty {
      js += ",\n  plugins: [\(plugins.map { $0.toJavaScript() }.joined(separator: ", "))]"
    }

    js += "\n}"
    return js
  }

  private func dataToJavaScript() -> String {
    var js = "{\n"

    if let labels = data.labels {
      js += "    labels: [\(labels.map { "'\($0)'" }.joined(separator: ", "))],\n"
    }

    js += "    datasets: [\n"
    let datasetStrings = data.datasets.map { dataset in
      let dict = dataset.toDictionary()
      return dictionaryToJavaScript(dict, indent: "      ")
    }
    js += datasetStrings.joined(separator: ",\n")
    js += "\n    ]\n  }"

    return js
  }

  private func dictionaryToJavaScript(_ dict: [String: Any], indent: String = "") -> String {
    var js = "\(indent){\n"

    for (key, value) in dict {
      js += "\(indent)  \(key): "

      switch value {
      case let str as String:
        // Check if it's already a JS expression (starts with function, contains =>)
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
      case let array as [Any]:
        js += "[\(array.map { arrayElementToJS($0) }.joined(separator: ", "))]"
      case let dict as [String: Any]:
        js += dictionaryToJavaScript(dict, indent: indent + "  ")
      default:
        js += "null"
      }

      js += ",\n"
    }

    // Remove last comma and newline
    if js.hasSuffix(",\n") {
      js.removeLast(2)
      js += "\n"
    }

    js += "\(indent)}"
    return js
  }

  private func arrayElementToJS(_ element: Any) -> String {
    switch element {
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

// MARK: - Builder Pattern
extension ChartConfiguration {
  public struct Builder {
    private var type: ChartType
    private var data: ChartData?
    private var options: ChartOptions?
    private var plugins: [ChartPlugin] = []

    public init(type: ChartType) {
      self.type = type
    }

    public func data(_ data: ChartData) -> Builder {
      var builder = self
      builder.data = data
      return builder
    }

    public func options(_ options: ChartOptions) -> Builder {
      var builder = self
      builder.options = options
      return builder
    }

    public func addPlugin(_ plugin: ChartPlugin) -> Builder {
      var builder = self
      builder.plugins.append(plugin)
      return builder
    }

    public func build() -> ChartConfiguration? {
      guard let data = data else { return nil }
      return ChartConfiguration(
        type: type,
        data: data,
        options: options,
        plugins: plugins.isEmpty ? nil : plugins
      )
    }
  }
}

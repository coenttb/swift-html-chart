import Foundation

/// Represents the data structure for a chart
public struct ChartData: Sendable, Codable {
  public let labels: [String]?
  public let datasets: [any ChartDataset]

  public init(labels: [String]? = nil, datasets: [any ChartDataset]) {
    self.labels = labels
    self.datasets = datasets
  }

  /// Convenience initializer for single dataset
  public init(labels: [String]? = nil, dataset: any ChartDataset) {
    self.labels = labels
    self.datasets = [dataset]
  }

  private enum CodingKeys: String, CodingKey {
    case labels
    case datasets
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.labels = try container.decodeIfPresent([String].self, forKey: .labels)

    // For decoding, we'd need to know the specific dataset types
    // This is a simplified version
    self.datasets = []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(labels, forKey: .labels)

    // Encode datasets as an array of dictionaries
    var datasetsArray = [[String: Any]]()
    for dataset in datasets {
      datasetsArray.append(dataset.toDictionary())
    }
    // Note: In production, you'd need proper JSON encoding
  }
}

/// Protocol for all chart datasets
public protocol ChartDataset: Sendable {
  var label: String { get }
  var data: [ChartValue] { get }
  var backgroundColor: ChartColor? { get }
  var borderColor: ChartColor? { get }
  var borderWidth: Double? { get }
  var hidden: Bool { get }
  var order: Int? { get }

  /// Convert to dictionary for JSON serialization
  func toDictionary() -> [String: Any]
}

/// Default implementation for common properties
extension ChartDataset {
  public var hidden: Bool { false }
  public var order: Int? { nil }

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

    return dict
  }
}

/// Base implementation for common dataset functionality
public struct BaseDataset: ChartDataset {
  public let label: String
  public let data: [ChartValue]
  public let backgroundColor: ChartColor?
  public let borderColor: ChartColor?
  public let borderWidth: Double?
  public let hidden: Bool
  public let order: Int?

  public init(
    label: String,
    data: [ChartValue],
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = nil,
    hidden: Bool = false,
    order: Int? = nil
  ) {
    self.label = label
    self.data = data
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.hidden = hidden
    self.order = order
  }

  /// Convenience initializer for numeric data
  public init(
    label: String,
    data: [Double],
    backgroundColor: ChartColor? = nil,
    borderColor: ChartColor? = nil,
    borderWidth: Double? = nil,
    hidden: Bool = false,
    order: Int? = nil
  ) {
    self.init(
      label: label,
      data: data.map { .number($0) },
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      hidden: hidden,
      order: order
    )
  }
}
